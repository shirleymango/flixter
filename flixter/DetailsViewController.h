//
//  DetailsViewController.h
//  flixter
//
//  Created by Shirley Zhu on 6/17/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *bigPoster;
@property (weak, nonatomic) IBOutlet UILabel *overview;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;
@property (nonatomic, strong) NSDictionary *detailDict;
@end

NS_ASSUME_NONNULL_END
