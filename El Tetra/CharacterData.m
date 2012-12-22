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

@synthesize soulStats = _soulStats;
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
- (NSDictionary *)primaryStats
{
    if (!_primaryStats) {
        NSDictionary *stats = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInt:3],
                               CHARACTER_PRIMARY_FEROCITY,
                               [NSNumber numberWithInt:2],
                               CHARACTER_PRIMARY_ACCURACY,
                               [NSNumber numberWithInt:1],
                               CHARACTER_PRIMARY_AGILITY,
                               [NSNumber numberWithInt:3],
                               CHARACTER_PRIMARY_RESILIENCE,
                               [NSNumber numberWithInt:2],
                               CHARACTER_PRIMARY_CHI,
                               nil];
        _primaryStats = stats;
    }
    return _primaryStats;
}


+ (NSOrderedSet *)soulStatsPresentationOrder
{
    return [NSOrderedSet orderedSetWithObjects:CHARACTER_SOUL_BODY,
            CHARACTER_SOUL_MIND,
            CHARACTER_SOUL_SPIRIT,
            nil];
}

+ (NSOrderedSet *)primaryStatsPresentationOrder
{
    return [NSOrderedSet orderedSetWithObjects:
            CHARACTER_PRIMARY_FEROCITY,
            CHARACTER_PRIMARY_ACCURACY,
            CHARACTER_PRIMARY_AGILITY,
            CHARACTER_PRIMARY_RESILIENCE,
            CHARACTER_PRIMARY_CHI,
            nil];
}

@end
