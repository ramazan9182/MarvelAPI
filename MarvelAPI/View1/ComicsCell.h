//
//  ComicsCell.h
//  MarvelAPI
//
//  Created by Ramazan Ceylan on 22.11.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComicsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgComicsDetail;
@property (strong, nonatomic) IBOutlet UILabel *lblComicsDetail;
@property (strong, nonatomic) IBOutlet UILabel *lblComicsTitle;

@end

NS_ASSUME_NONNULL_END
