//
//  PokemonBase.h
//  Pokedex
//
//  Created by Karen Rodriguez on 5/22/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PokemonBase : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly) NSURL *url;

- (instancetype)initWithName:(NSString *)name url:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
