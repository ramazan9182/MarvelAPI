//
//  CharacterDetailVC.m
//  MarvelAPI
//
//  Created by Ramazan Ceylan on 22.11.2021.
//

#import "CharacterDetailVC.h"

@interface CharacterDetailVC ()

@end

@implementation CharacterDetailVC
@synthesize comicsArray,character;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self serviceCall];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return comicsArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    UILabel *lbl =  [UILabel new];
    lbl.text = character.name;
    return lbl.text;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ComicsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comicsCell"];
    [tableView registerNib:[UINib nibWithNibName:@"ComicsCell" bundle:nil] forCellReuseIdentifier:@"comicsCell"];
    cell=[tableView dequeueReusableCellWithIdentifier:@"comicsCell"];
    Comics *cmcs =[comicsArray objectAtIndex:indexPath.row];
    if ([cmcs.comicsDescription isEqualToString:@""]) {
        cell.lblComicsDetail.text=@"Description Not Found!!!";
    }else{
        cell.lblComicsDetail.text=cmcs.comicsDescription;
    }
    cell.lblComicsTitle.text=cmcs.comicsTitle;
    cell.lblComicsTitle.adjustsFontSizeToFitWidth = YES;
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 414, 5)];
    cell.imgComicsDetail.layer.cornerRadius=10;
    separatorLineView.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:separatorLineView];
    [cell.imgComicsDetail setImageWithURL:[NSURL URLWithString:cmcs.comicsThumbnailUrl]];
    return cell;
}

-(void)serviceCall{
    Home *home=[Home new];
    [self getRequest:[NSString stringWithFormat:@"%@/v1/public/characters/%@/comics?limit=5&ts=%@&apikey=%@&hash=%@",home.baseURL,character.characterId,home.timeStamp,home.apiKey,home.hashKey] completion:^(NSDictionary *_Nonnull dictionary, NSError *_Nonnull error) {
    }];
}

-(void) getRequest:(NSString *)requestURL completion:(void (^)(NSDictionary *, NSError *)) completion{
    AFHTTPSessionManager *manager=[[AFHTTPSessionManager alloc] init];
    [manager GET:requestURL parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask *operation, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if(completion) completion((NSDictionary *)responseObject[@"data"][@"result"],nil);
        NSDictionary *data = [responseObject valueForKey:@"data"];
        NSArray *results = [data valueForKey:@"results"];
        comicsArray= [NSMutableArray arrayWithCapacity:results.count];
        for (NSDictionary *item in results) {

            Comics *com = [Comics new];
            com.comicsDescription = [item valueForKey:@"description"];
            com.comicsId = [item valueForKey:@"id"];
            com.comicsTitle = [item valueForKey:@"title"];
            NSDictionary *thumbnail = [item valueForKey:@"thumbnail"];
            NSString *thumbnailUrl = [NSString stringWithFormat:@"%@.%@", [thumbnail valueForKey:@"path"], [thumbnail valueForKey:@"extension"]];
            com.comicsThumbnailUrl = [thumbnailUrl stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
            [comicsArray addObject:com];
            
        }
        [self.tableview reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(completion) completion(nil,error);
    }];
}

@end
