//
//  Character.m
//  El Tetra
//
//  Created by Matthew Kameron on 30/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "Character.h"

@implementation Character
@synthesize name = _name;
- (NSString *)name {
    if (!_name) _name = [NSString stringWithFormat:@"%d", arc4random()];
    return _name;
}

@synthesize stats = _stats;
- (CharacterStatPresenter *)stats {
    if (!_stats) _stats = [[CharacterStatPresenter alloc] init];
    return _stats;
}

@synthesize loadouts = _loadouts;
- (NSMutableArray *)loadouts {
    if (!_loadouts) _loadouts = [NSMutableArray arrayWithObject:[CharacterLoadout defaultLoadout]];
    return _loadouts;
}

@end
