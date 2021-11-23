//
//  CharacterDetailVC.h
//  MarvelAPI
//
//  Created by Ramazan Ceylan on 22.11.2021.
//

#import <UIKit/UIKit.h>
#import "Character.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "AFNetworking.h"
#import <AFNetworking/AFNetworking.h>
#import "ComicsCell.h"
#import "Comics.h"
#import "Home.h"

NS_ASSUME_NONNULL_BEGIN

@interface CharacterDetailVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property NSMutableArray *comicsArray;
@property Character *character;

@end

NS_ASSUME_NONNULL_END
