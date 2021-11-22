//
//  Comics.h
//  MarvelAPI
//
//  Created by Ramazan Ceylan on 22.11.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Comics : NSObject

@property(nonatomic, strong) NSNumber *commicsId;
@property(nonatomic, strong) NSString *commicsDescription;
@property(nonatomic, strong) NSString *commicsThumbnailUrl;
@property(nonatomic, strong) NSString *commicsTitle;

@end

NS_ASSUME_NONNULL_END
