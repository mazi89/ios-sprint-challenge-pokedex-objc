//
//  Pokemon.m
//  Pokedex
//
//  Created by Karen Rodriguez on 5/22/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

#import "Pokemon.h"

@implementation Pokemon

- (instancetype) initWithName:(NSString *)name iD:(int)iD abilities:(NSArray<NSString *> *)abilities {
    self = [super init];
    if (self) {
        _name = [name copy];
        _iD = iD;
        // MARK:- QUESTION FOR JON: Given that an NSMutableArray and an NSArray are two entirely different objects, I shouldn't worry about passing this by copy right?
        _abilities = abilities;
    }
    return self;
}

@end
