//
//  Pokemon.h
//  Pokedex
//
//  Created by Karen Rodriguez on 5/22/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly) int iD;
@property (nonatomic, readonly) NSArray<NSString *> *abilities;

- (instancetype) initWithName:(NSString *)name iD:(int)iD abilities:(NSArray<NSString *> *)abilities;

@end

NS_ASSUME_NONNULL_END
