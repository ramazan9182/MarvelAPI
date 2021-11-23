//
//  Comics.h
//  MarvelAPI
//
//  Created by Ramazan Ceylan on 22.11.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Comics : NSObject
@property(nonatomic, strong) NSNumber *comicsId;
@property(nonatomic, strong) NSString *comicsDescription;
@property(nonatomic, strong) NSString *comicsThumbnailUrl;
@property(nonatomic, strong) NSString *comicsTitle;

@end

NS_ASSUME_NONNULL_END
