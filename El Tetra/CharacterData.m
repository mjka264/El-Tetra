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
- (NSDictionary *)abilityStats
{
    if (!_abilityStats) {
        NSDictionary *stats = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInt:3],
                               CHARACTER_ABILITY_ARTFULWEAPONS,
                               [NSNumber numberWithInt:2],
                               CHARACTER_ABILITY_DAOISM,
                               [NSNumber numberWithInt:1],
                               CHARACTER_ABILITY_INITIATIVE,
                               [NSNumber numberWithInt:3],
                               CHARACTER_ABILITY_LEAPFLOAT,
                               [NSNumber numberWithInt:2],
                               CHARACTER_ABILITY_MULTIPLEATTACKS,
                               [NSNumber numberWithInt:3],
                               CHARACTER_ABILITY_PRIMALWATER,
                               [NSNumber numberWithInt:2],
                               CHARACTER_ABILITY_CRITICALSTRIKES,
                               [NSNumber numberWithInt:1],
                               CHARACTER_ABILITY_PRIMALAIR,
                               [NSNumber numberWithInt:3],
                               CHARACTER_ABILITY_STRENGTHWITHIN,
                               [NSNumber numberWithInt:2],
                               CHARACTER_ABILITY_PROJECTILEWEAPONS,
                               nil];
        _abilityStats = stats;
    }
    return _abilityStats;
}

@synthesize soulStats = _soulStats;
- (NSDictionary *)soulStats
{
    if (!_soulStats) {
        NSDictionary *stats = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithInt:3],
                               CHARACTER_SOUL_BODY,
                               [NSNumber numberWithInt:2],
                               CHARACTER_SOUL_MIND,
                               [NSNumber numberWithInt:1],
                               CHARACTER_SOUL_SPIRIT,
                               nil];
        _soulStats = stats;
    }
    return _soulStats;
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

@synthesize skillStats = _skillStats;
- (NSDictionary *)skillStats
{
    NSNumber *fireStat   = [self.primaryStats objectForKey:CHARACTER_PRIMARY_FEROCITY];
    NSNumber *airStat    = [self.primaryStats objectForKey:CHARACTER_PRIMARY_ACCURACY];
    NSNumber *waterStat  = [self.primaryStats objectForKey:CHARACTER_PRIMARY_AGILITY];
    NSNumber *earthStat  = [self.primaryStats objectForKey:CHARACTER_PRIMARY_RESILIENCE];
    NSNumber *bodyStat   = [self.soulStats objectForKey:CHARACTER_SOUL_BODY];
    NSNumber *mindStat   = [self.soulStats objectForKey:CHARACTER_SOUL_MIND];
    NSNumber *spiritStat = [self.soulStats objectForKey:CHARACTER_SOUL_SPIRIT];

    return [NSDictionary dictionaryWithObjectsAndKeys:
            fireStat < bodyStat? fireStat : bodyStat,
            CHARACTER_SKILL_FIRE_BODY,
            fireStat < mindStat? fireStat : mindStat,
            CHARACTER_SKILL_FIRE_MIND,
            fireStat < spiritStat? fireStat : spiritStat,
            CHARACTER_SKILL_FIRE_SPIRIT,
            airStat < bodyStat? airStat : bodyStat,
            CHARACTER_SKILL_AIR_BODY,
            airStat < mindStat? airStat : mindStat,
            CHARACTER_SKILL_AIR_MIND,
            airStat < spiritStat? airStat : spiritStat,
            CHARACTER_SKILL_AIR_SPIRIT,
            waterStat < bodyStat? waterStat : bodyStat,
            CHARACTER_SKILL_WATER_BODY,
            waterStat < mindStat? waterStat : mindStat,
            CHARACTER_SKILL_WATER_MIND,
            waterStat < spiritStat? waterStat : spiritStat,
            CHARACTER_SKILL_WATER_SPIRIT,
            earthStat < bodyStat? earthStat : bodyStat,
            CHARACTER_SKILL_EARTH_BODY,
            earthStat < mindStat? earthStat : mindStat,
            CHARACTER_SKILL_EARTH_MIND,
            earthStat < spiritStat? earthStat : spiritStat,
            CHARACTER_SKILL_EARTH_SPIRIT,
            nil];
}

+ (NSOrderedSet *)soulStatsPresentationOrder
{
    return [NSOrderedSet orderedSetWithObjects:
            CHARACTER_SOUL_BODY,
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

+ (NSOrderedSet *)fireSkillsPresentationOrder
{
    return [NSOrderedSet orderedSetWithObjects:
            CHARACTER_SKILL_FIRE_BODY,
            CHARACTER_SKILL_FIRE_MIND,
            CHARACTER_SKILL_FIRE_SPIRIT,
            nil];
}

+ (NSOrderedSet *)waterSkillsPresentationOrder
{
    return [NSOrderedSet orderedSetWithObjects:
            CHARACTER_SKILL_WATER_BODY,
            CHARACTER_SKILL_WATER_MIND,
            CHARACTER_SKILL_WATER_SPIRIT,
            nil];
}

+ (NSOrderedSet *)airSkillsPresentationOrder
{
    return [NSOrderedSet orderedSetWithObjects:
            CHARACTER_SKILL_AIR_BODY,
            CHARACTER_SKILL_AIR_MIND,
            CHARACTER_SKILL_AIR_SPIRIT,
            nil];
}

+ (NSOrderedSet *)earthSkillsPresentationOrder
{
    return [NSOrderedSet orderedSetWithObjects:
            CHARACTER_SKILL_EARTH_BODY,
            CHARACTER_SKILL_EARTH_MIND,
            CHARACTER_SKILL_EARTH_SPIRIT,
            nil];
}

+ (NSOrderedSet *)fireAbilitiesPresentationOrder
{
    return [NSOrderedSet orderedSetWithObjects:
            CHARACTER_ABILITY_REND,
            CHARACTER_ABILITY_SPELLSWORD,
            CHARACTER_ABILITY_PRIMALFIRE,
            nil];
}

+ (NSOrderedSet *)airAbilitiesPresentationOrder
{
    return [NSOrderedSet orderedSetWithObjects:
            CHARACTER_ABILITY_ARTFULWEAPONS,
            CHARACTER_ABILITY_BRUTALWEAPONS,
            CHARACTER_ABILITY_PROJECTILEWEAPONS,
            CHARACTER_ABILITY_CRITICALSTRIKES,
            CHARACTER_ABILITY_PRIMALAIR,
            nil];
}

+ (NSOrderedSet *)waterAbilitiesPresentationOrder
{
    return [NSOrderedSet orderedSetWithObjects:
            CHARACTER_ABILITY_INITIATIVE,
            CHARACTER_ABILITY_MULTIPLEATTACKS,
            CHARACTER_ABILITY_LEAPFLOAT,
            CHARACTER_ABILITY_PRIMALWATER,
            nil];
}

+ (NSOrderedSet *)earthAbilitiesPresentationOrder
{
    return [NSOrderedSet orderedSetWithObjects:
            CHARACTER_ABILITY_DEFENSIVEPAUSE,
            CHARACTER_ABILITY_STRENGTHWITHIN,
            CHARACTER_ABILITY_PRIMALEARTH,
            nil];
}

+ (NSOrderedSet *)chiAbilitiesPresentationOrder
{
    return [NSOrderedSet orderedSetWithObjects:
            CHARACTER_ABILITY_DAOISM,
            CHARACTER_ABILITY_OFFWORLDCONTACT,
            CHARACTER_ABILITY_PRIMALFIRE,
            CHARACTER_ABILITY_PRIMALAIR,
            CHARACTER_ABILITY_PRIMALWATER,
            CHARACTER_ABILITY_PRIMALEARTH,
            CHARACTER_ABILITY_SHIFTINGBODY,
            CHARACTER_ABILITY_SHIFTINGMINDSPIRIT,
            nil];
}

@end
