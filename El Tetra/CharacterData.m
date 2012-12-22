//
//  CharacterDataModel.m
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterData.h"

@implementation CharacterData
@synthesize abilityStats = _abilityStats;

- (NSDictionary *)soulStats
{
    if (!_abilityStats) {
        NSDictionary *stats = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInt:3],
                               CHARACTER_SOUL_BODY,
                               [NSNumber numberWithInt:2],
                               CHARACTER_SOUL_MIND,
                               [NSNumber numberWithInt:1],
                               CHARACTER_SOUL_SPIRIT,
                               nil];
        _abilityStats = stats;
    }
    return _abilityStats;
}
@synthesize primaryStats = _primaryStats;
@synthesize soulStats = _soulStats;

+ (NSOrderedSet *)soulStatsPresentationOrder
{
    return [NSOrderedSet orderedSetWithObjects:CHARACTER_SOUL_BODY,
            CHARACTER_SOUL_MIND,
            CHARACTER_SOUL_SPIRIT,
            nil];
}

@end
