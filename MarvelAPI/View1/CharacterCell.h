//
//  CharacterCell.h
//  MarvelAPI
//
//  Created by Ramazan Ceylan on 20.11.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CharacterCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgCharacter;
@property (strong, nonatomic) IBOutlet UILabel *lblCharacter;

@end

NS_ASSUME_NONNULL_END
