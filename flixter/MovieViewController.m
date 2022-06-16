//
//  MovieViewController.m
//  flixter
//
//  Created by Shirley Zhu on 6/15/22.
//

#import "MovieViewController.h"
#import "MovieTableViewCell.h"

@interface MovieViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *myArray;

@end

@implementation MovieViewController
NSArray *test;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    test = @[@"a", @"b", @"c"];
        self.tableView.dataSource = self;
    
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=c98d20c9e7b2d705c4d6a5bcfd6687eb"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

               // TODO: Get the array of movies
               NSArray *myArray = dataDictionary[@"results"];
               
               NSLog(@"%@", myArray);
               
               // TODO: Store the movies in a property to use elsewhere
               
               // TODO: Reload your table view data
               
           }
       }];
    [task resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"movieCell"];
//    cell.textLabel.text = test[indexPath.row];
    
    return  cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return test.count;
}
@end
