//
//  Pokemon.m
//  Pokedex
//
//  Created by Karen Rodriguez on 5/22/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

#import "Pokemon.h"

@implementation Pokemon

- (instancetype) initWithName:(NSString *)name{
    self = [super init];
    if (self) {
        _name = [name copy];
    }
    return self;
}

@end
