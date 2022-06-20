//
//  MovieViewController.m
//  flixter
//
//  Created by Shirley Zhu on 6/15/22.
//

#import "MovieViewController.h"
#import "MovieTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

@interface MovieViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinningIndicator;

@property (nonatomic, strong) NSArray *movies;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
//    movies = @[@"a", @"b", @"c"];
        self.tableView.dataSource = self;
    [self fetchMovies];
    
    //Initialize a UIRefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    //Bind the action to the refresh control
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    //Insert the refresh control into the list
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=c98d20c9e7b2d705c4d6a5bcfd6687eb"];
     
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Not connected to Internet" preferredStyle:UIAlertControllerStyleAlert];
               UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                       //button click event
                                   }];
               UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
               [alert addAction:cancel];
               [alert addAction:ok];
               [self presentViewController:alert animated:YES completion:nil];
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               // Get the array of movies
               self.movies = dataDictionary[@"results"];
//               for (NSDictionary *movie in self.movies) {
//                   NSLog(@"%@", movie[@"title"]);
//               }
            
               // Reload your table view data
               [self.tableView reloadData];
               
           }
       }];
    [task resume];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    DetailsViewController *detailVC = [segue destinationViewController];
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    detailVC.detailDict = self.movies[indexPath.row];

}
 

- (void)fetchMovies {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=c98d20c9e7b2d705c4d6a5bcfd6687eb"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               // Get the array of movies
               self.movies = dataDictionary[@"results"];
               for (NSDictionary *movie in self.movies) {
                   NSLog(@"%@", movie[@"title"]);
               }
               [self.spinningIndicator startAnimating];
               // Reload your table view data
               [self.tableView reloadData];
           }
        // Tell the refreshControl to stop spinning
        [self.refreshControl endRefreshing];
        
       }];
    [self.spinningIndicator stopAnimating];
    [task resume];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"movieCell"];
    NSDictionary *movie = self.movies[indexPath.row];
    cell.title.text = movie[@"title"];
    cell.summary.text = movie[@"overview"];
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [cell.image setImageWithURL:posterURL];
    return  cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}
@end
