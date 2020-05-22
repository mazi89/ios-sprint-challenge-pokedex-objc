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

@property (nonatomic, copy) NSString *name;
@property (nonatomic) int iD;
@property (nonatomic) NSMutableArray<NSString *> *abilities;
@property (nonatomic) NSURL *url;
@property (nonatomic) NSData *imageData;

- (instancetype) initWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
