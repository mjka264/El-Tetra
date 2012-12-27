//
//  CharacterLoadout.m
//  El Tetra
//
//  Created by Matthew Kameron on 27/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterLoadout.h"

@interface CharacterLoadout ()

@end

@implementation CharacterLoadout

@synthesize mainhand = _mainhand;
@synthesize offhand = _offhand;
@synthesize armour = _armour;
@synthesize gear = _gear;
- (NSArray *)gear {
    if (!_gear) _gear = [[NSArray alloc] init];
    return _gear;
}

+ (CharacterLoadout *)defaultLoadout {
    CharacterLoadout *loadout = [[CharacterLoadout alloc] init];
    loadout.mainhand = [[Item allItems] objectAtIndex:0];
    loadout.offhand = [[Item allItems] objectAtIndex:2];
    return loadout;
}

@end
