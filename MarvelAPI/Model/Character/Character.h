//
//  Character.h
//  MarvelAPI
//
//  Created by Ramazan Ceylan on 20.11.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Character : NSObject
@property(nonatomic, strong) NSNumber *characterId;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *thumbnailUrl;

@end

NS_ASSUME_NONNULL_END
