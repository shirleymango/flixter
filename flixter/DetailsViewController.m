//
//  DetailsViewController.m
//  flixter
//
//  Created by Shirley Zhu on 6/17/22.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end
@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.overview.text = self.detailDict[@"overview"];
    self.movieTitle.text = self.detailDict[@"title"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
