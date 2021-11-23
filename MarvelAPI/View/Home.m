//
//  ViewController.m
//  MarvelAPI
//
//  Created by Ramazan Ceylan on 20.11.2021.
//

//'##::::'##::::'###::::'########::'##::::'##:'########:'##:::::::
// ###::'###:::'## ##::: ##.... ##: ##:::: ##: ##.....:: ##:::::::
// ####'####::'##:. ##:: ##:::: ##: ##:::: ##: ##::::::: ##:::::::
// ## ### ##:'##:::. ##: ########:: ##:::: ##: ######::: ##:::::::
// ##. #: ##: #########: ##.. ##:::. ##:: ##:: ##...:::: ##:::::::
// ##:.:: ##: ##.... ##: ##::. ##:::. ## ##::: ##::::::: ##:::::::
// ##:::: ##: ##:::: ##: ##:::. ##:::. ###:::: ########: ########:
//..:::::..::..:::::..::..:::::..:::::...:::::........::........::
                                                                
#import "Home.h"
#define API_KEY @"834ec44d432bfdec1d32b9697c19aa9a"
#define TIME_STAMP @"1"
#define HASH_KEY @"4dc4a8e6b6cdc1565e63603351203834"
#define LIMIT @"100"
@interface Home ()
@property (nonatomic) int selected;
@end

@implementation Home
@synthesize charactersArray,character;

- (id)init{
    if (self = [super init]) {
        self.apiKey=API_KEY;
        self.timeStamp=TIME_STAMP;
        self.hashKey=HASH_KEY;
        self.baseURL=@"https://gateway.marvel.com:443";
        self.limit=LIMIT;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self init];
    [self serviceCall];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return charactersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CharacterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"characterCell"];
    [tableView registerNib:[UINib nibWithNibName:@"CharacterCell" bundle:nil] forCellReuseIdentifier:@"characterCell"];
    cell=[tableView dequeueReusableCellWithIdentifier:@"characterCell"];
    Character *chr =[charactersArray objectAtIndex:indexPath.row];
    cell.lblCharacter.text=chr.name;
    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 414, 5)];
    cell.imgCharacter.layer.cornerRadius=cell.imgCharacter.layer.cornerRadius=CGRectGetWidth(cell.imgCharacter.frame)/18.0f;
    separatorLineView.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:separatorLineView];
    [cell.imgCharacter setImageWithURL:[NSURL URLWithString:chr.thumbnailUrl] placeholderImage:[UIImage imageNamed:chr.name]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selected=indexPath.row;
    [self performSegueWithIdentifier:@"characterDetails" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    CharacterDetailVC *dc = [segue destinationViewController];
    dc.character=[charactersArray objectAtIndex:_selected];
}

-(void) getCharacters:(NSString *)requestURL completion:(void (^)(NSDictionary *, NSError *)) completion{
    AFHTTPSessionManager *manager=[[AFHTTPSessionManager alloc] init];
    [manager GET:requestURL parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSLog(@"Response %@",responseObject);
        if(completion) completion((NSDictionary *)responseObject[@"data"][@"result"],nil);
        [self mappingGetCharacters:responseObject];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull err) {
        if (completion) {
            completion(nil,err);
        }
    }];
}

-(void) mappingGetCharacters : (NSMutableDictionary *) responseObject{
    NSDictionary *data = [responseObject valueForKey:@"data"];
    NSArray *results = [data valueForKey:@"results"];
    charactersArray= [NSMutableArray arrayWithCapacity:results.count];
    
    for (NSDictionary *item in results) {
        Character *character = [Character new];
        character.name = [item valueForKey:@"name"];
        character.characterId = [item valueForKey:@"id"];
        NSDictionary *thumbnail = [item valueForKey:@"thumbnail"];
        NSString *thumbnailUrl = [NSString stringWithFormat:@"%@.%@", [thumbnail valueForKey:@"path"], [thumbnail valueForKey:@"extension"]];
        character.thumbnailUrl = [thumbnailUrl stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
        [charactersArray addObject:character];
    }
    [self.tableview reloadData];
}

-(void) serviceCall{
    [self getCharacters:[NSString stringWithFormat:@"%@/v1/public/characters?limit=%@&ts=%@&apikey=%@&hash=%@",self.baseURL,self.limit,self.timeStamp,self.apiKey,self.hashKey] completion:^(NSDictionary *_Nonnull dictionary, NSError *_Nonnull error){
    }];
}
@end
