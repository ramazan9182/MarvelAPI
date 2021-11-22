//
//  ViewController.h
//  MarvelAPI
//
//  Created by Ramazan Ceylan on 20.11.2021.
//

#import <UIKit/UIKit.h>
#import "CharacterCell.h"
#import "AFNetworking.h"
#import <AFNetworking/AFNetworking.h>
#import "Character.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "CharacterDetailVC.h"



@interface Home : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property NSString *apiKey;
@property NSString *timeStamp;
@property NSString *hashKey;
@property NSString *baseURL;
@property NSString *limit;
@property NSMutableArray *charactersArray;
@property Character *character;

-(void) serviceCall;
-(void) getCharacters:(NSString *)requestURL completion:(void (^)(NSDictionary *, NSError *)) completion;

@end

