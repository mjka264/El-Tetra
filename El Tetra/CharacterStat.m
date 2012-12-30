//
//  CharacterSingleStat.m
//  El Tetra
//
//  Created by Matthew Kameron on 30/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterStat.h"
#import "CharacterStatPresenter.h"

// This is used to keep a copy of a "blank" character. It is only released as a copy.
// It is initiated at the bottom of this file
NSArray *_allStats = nil;


@interface CharacterStat ()
+ (void)buildAllStats;
+ (CharacterStat *)createStat:(NSString *)description
                 defaultValue:(NSInteger)startingStatValue
                        group:(t_CharacterStatGroup)groupStatBelongsTo
                      element:(t_CharacterStatElement)associatedElement
                         soul:(t_CharacterStatSoulLink)associatedSoulStat;

@end


@implementation CharacterStat
@synthesize description = _description;
@synthesize groupMembership = _groupMembership;
@synthesize elementMembership = _elementMembership;
@synthesize soulMembership = _soulMembership;
@synthesize value = _value;

- (NSInteger)skillCost {
    if (self.groupMembership == CharacterStatGroupSoul) return 3;
    else if (self.groupMembership == CharacterStatGroupPrimary) return 2;
    else if (self.groupMembership == CharacterStatGroupSkills) {
        if (self.elementMembership == CharacterStatElementFire ||
            self.elementMembership == CharacterStatElementAir ||
            self.elementMembership == CharacterStatElementWater ||
            self.elementMembership == CharacterStatElementEarth) {
            return 1;
        } else {
            return 2;
        }
    }
    return 0;
}

- (NSInteger)minimumValue {
    if (self.groupMembership == CharacterStatGroupAbilities) {
        return 0;
    } else {
        return 1;
    }
}



- (id)copyWithZone:(NSZone *)zone {
    CharacterStat *copy = [[CharacterStat alloc] init];
    copy.description = self.description;
    copy.value = self.value;
    copy.groupMembership = self.groupMembership;
    copy.elementMembership = self.elementMembership;
    copy.soulMembership = self.soulMembership;
    return copy;
}

+ (CharacterStat *)createStat:(NSString *)description
                 defaultValue:(NSInteger)startingStatValue
                        group:(t_CharacterStatGroup)groupStatBelongsTo
                      element:(t_CharacterStatElement)associatedElement
                         soul:(t_CharacterStatSoulLink)associatedSoulStat {
    CharacterStat *stat = [[CharacterStat alloc] init];
    stat.description = description;
    stat.value = startingStatValue;
    stat.groupMembership = groupStatBelongsTo;
    stat.elementMembership = associatedElement;
    stat.soulMembership = associatedSoulStat;
    return stat;
}

+ (NSArray *)characterStatsSetCopy {
    if (!_allStats) [CharacterStat buildAllStats];
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[_allStats count]];
    for (CharacterStat *obj in _allStats) {
        [array addObject:[obj copy]];
    }
    return [array copy];
}

+ (void)buildAllStats {
    _allStats = @[
    
    // ---------- Soul ------------- //
    
    [CharacterStat createStat:@"Body" defaultValue:2
                        group:CharacterStatGroupSoul
                      element:CharacterStatElementNone
                         soul:CharacterStatSoulLinkBody],
    [CharacterStat createStat:@"Mind" defaultValue:2
                        group:CharacterStatGroupSoul
                      element:CharacterStatElementNone
                         soul:CharacterStatSoulLinkMind],
    [CharacterStat createStat:@"Spirit" defaultValue:2
                        group:CharacterStatGroupSoul
                      element:CharacterStatElementNone
                         soul:CharacterStatSoulLinkSpirit],
    
    // --------- Primary stats ---------- //
    
    [CharacterStat createStat:@"Ferocity" defaultValue:2
                        group:CharacterStatGroupPrimary
                      element:CharacterStatElementFire
                         soul:CharacterStatSoulLinkNone],
    [CharacterStat createStat:@"Precision" defaultValue:2
                        group:CharacterStatGroupPrimary
                      element:CharacterStatElementAir
                         soul:CharacterStatSoulLinkNone],
    [CharacterStat createStat:@"Agility" defaultValue:2
                        group:CharacterStatGroupPrimary
                      element:CharacterStatElementWater
                         soul:CharacterStatSoulLinkNone],
    [CharacterStat createStat:@"Resilience" defaultValue:2
                        group:CharacterStatGroupPrimary
                      element:CharacterStatElementEarth
                         soul:CharacterStatSoulLinkNone],
    [CharacterStat createStat:@"Chi" defaultValue:2
                        group:CharacterStatGroupPrimary
                      element:CharacterStatElementChi
                         soul:CharacterStatSoulLinkNone],
    
    // --------- Skills --------------- //
    
    [CharacterStat createStat:@"Power, speed, lifting" defaultValue:0
                        group:CharacterStatGroupSkills
                      element:CharacterStatElementFire
                         soul:CharacterStatSoulLinkBody],
    [CharacterStat createStat:@"Instinct, innovation, insight, synthesis" defaultValue:0
                        group:CharacterStatGroupSkills
                      element:CharacterStatElementFire
                         soul:CharacterStatSoulLinkMind],
    [CharacterStat createStat:@"Passion, agression, assertion, intimidation" defaultValue:0
                        group:CharacterStatGroupSkills
                      element:CharacterStatElementFire
                         soul:CharacterStatSoulLinkSpirit],
    
    [CharacterStat createStat:@"Craft, lockpicking" defaultValue:0
                        group:CharacterStatGroupSkills
                      element:CharacterStatElementAir
                         soul:CharacterStatSoulLinkBody],
    [CharacterStat createStat:@"Logic, science, reasoning, investigation, memory" defaultValue:0
                        group:CharacterStatGroupSkills
                      element:CharacterStatElementAir
                         soul:CharacterStatSoulLinkMind],
    [CharacterStat createStat:@"Culture, disguise, trickery, cunning" defaultValue:0
                        group:CharacterStatGroupSkills
                      element:CharacterStatElementAir
                         soul:CharacterStatSoulLinkSpirit],
    
    [CharacterStat createStat:@"Balance, stealth, reflexes" defaultValue:0
                        group:CharacterStatGroupSkills
                      element:CharacterStatElementWater
                         soul:CharacterStatSoulLinkBody],
    [CharacterStat createStat:@"Language, interpretation" defaultValue:0
                        group:CharacterStatGroupSkills
                      element:CharacterStatElementWater
                         soul:CharacterStatSoulLinkMind],
    [CharacterStat createStat:@"Empathy, charm, misdirection" defaultValue:0
                        group:CharacterStatGroupSkills
                      element:CharacterStatElementWater
                         soul:CharacterStatSoulLinkSpirit],
    
    [CharacterStat createStat:@"Fortitude, stamina, labour" defaultValue:0
                        group:CharacterStatGroupSkills
                      element:CharacterStatElementEarth
                         soul:CharacterStatSoulLinkBody],
    [CharacterStat createStat:@"Perception, observation, procedure, tracking" defaultValue:0
                        group:CharacterStatGroupSkills
                      element:CharacterStatElementEarth
                         soul:CharacterStatSoulLinkMind],
    [CharacterStat createStat:@"Confidence, bravery, diligence, patience" defaultValue:0
                        group:CharacterStatGroupSkills
                      element:CharacterStatElementEarth
                         soul:CharacterStatSoulLinkSpirit],
    
    // ------------ Abilities -------- //
    
    [CharacterStat createStat:@"Rend" defaultValue:0
                        group:CharacterStatGroupAbilities
                      element:CharacterStatElementFire
                         soul:CharacterStatSoulLinkNone],
    [CharacterStat createStat:@"Spellsword" defaultValue:0
                        group:CharacterStatGroupAbilities
                      element:CharacterStatElementFire
                         soul:CharacterStatSoulLinkNone],
    
    [CharacterStat createStat:STAT_ARTFUL defaultValue:0
                        group:CharacterStatGroupAbilities
                      element:CharacterStatElementAir
                         soul:CharacterStatSoulLinkNone],
    [CharacterStat createStat:STAT_BRUTAL defaultValue:0
                        group:CharacterStatGroupAbilities
                      element:CharacterStatElementAir
                         soul:CharacterStatSoulLinkNone],
    [CharacterStat createStat:@"Critical strikes" defaultValue:0
                        group:CharacterStatGroupAbilities
                      element:CharacterStatElementAir
                         soul:CharacterStatSoulLinkNone],
    [CharacterStat createStat:STAT_PROJECTILE defaultValue:0
                        group:CharacterStatGroupAbilities
                      element:CharacterStatElementAir
                         soul:CharacterStatSoulLinkNone],
    
    [CharacterStat createStat:STAT_INITIATIVE defaultValue:0
                        group:CharacterStatGroupAbilities
                      element:CharacterStatElementWater
                         soul:CharacterStatSoulLinkNone],
    [CharacterStat createStat:@"Leap/float" defaultValue:0
                        group:CharacterStatGroupAbilities
                      element:CharacterStatElementWater
                         soul:CharacterStatSoulLinkNone],
    [CharacterStat createStat:@"Multiple attacks" defaultValue:0
                        group:CharacterStatGroupAbilities
                      element:CharacterStatElementWater
                         soul:CharacterStatSoulLinkNone],
    
    [CharacterStat createStat:@"Defensive pause" defaultValue:0
                        group:CharacterStatGroupAbilities
                      element:CharacterStatElementEarth
                         soul:CharacterStatSoulLinkNone],
    [CharacterStat createStat:@"Strength within" defaultValue:0
                        group:CharacterStatGroupAbilities
                      element:CharacterStatElementEarth
                         soul:CharacterStatSoulLinkNone],
    
    [CharacterStat createStat:@"Daoism" defaultValue:0
                        group:CharacterStatGroupAbilities
                      element:CharacterStatElementChi
                         soul:CharacterStatSoulLinkNone],
    [CharacterStat createStat:@"Shaping" defaultValue:0
                        group:CharacterStatGroupAbilities
                      element:CharacterStatElementChi
                         soul:CharacterStatSoulLinkNone],
    [CharacterStat createStat:@"Planewalking" defaultValue:0
                        group:CharacterStatGroupAbilities
                      element:CharacterStatElementChi
                         soul:CharacterStatSoulLinkNone],
    
    [CharacterStat createStat:@"Primal fire" defaultValue:0
                        group:CharacterStatGroupAbilities
                      element:CharacterStatElementFireChi
                         soul:CharacterStatSoulLinkNone],
    [CharacterStat createStat:@"Primal Air" defaultValue:0
                        group:CharacterStatGroupAbilities
                      element:CharacterStatElementAirChi
                         soul:CharacterStatSoulLinkNone],
    [CharacterStat createStat:@"Primal Water" defaultValue:0
                        group:CharacterStatGroupAbilities
                      element:CharacterStatElementWaterChi
                         soul:CharacterStatSoulLinkNone],
    [CharacterStat createStat:@"Primal Earth" defaultValue:0
                        group:CharacterStatGroupAbilities
                      element:CharacterStatElementEarthChi
                         soul:CharacterStatSoulLinkNone],
    ];
}

@end
