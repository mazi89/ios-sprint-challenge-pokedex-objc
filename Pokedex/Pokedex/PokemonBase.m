//
//  PokemonBase.m
//  Pokedex
//
//  Created by Karen Rodriguez on 5/22/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

#import "PokemonBase.h"

@implementation PokemonBase

- (instancetype)initWithName:(NSString *)name url:(NSURL *)url {
    self = [super init];
    if (self) {
        _name = [name copy];
        _url = url;
    }
    return self;
}

@end
