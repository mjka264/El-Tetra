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


@interface CharacterStat ()
+ (CharacterStat *)createStat:(NSString *)statName
                 defaultValue:(NSInteger)startingStatValue
                        group:(t_CharacterStatGroup)groupStatBelongsTo
                      element:(t_CharacterStatElement)associatedElement
                         soul:(t_CharacterStatSoulLink)associatedSoulStat;
+ (CharacterStat *)createStat:(NSString *)statName
                  derivedFrom:(NSArray *)parentStats
                        group:(t_CharacterStatGroup)groupStatBelongsTo
                      element:(t_CharacterStatElement)associatedElement
                         soul:(t_CharacterStatSoulLink)associatedSoulStat;
@property (nonatomic, strong) NSArray *parentStats;
@end


@implementation CharacterStat
@synthesize statName = _statName;
@synthesize groupMembership = _groupMembership;
@synthesize elementMembership = _elementMembership;
@synthesize soulMembership = _soulMembership;

// When a stat has parents, use the lower of those stats rather than any intrinsic value
@synthesize parentStats = _parentStats;
@synthesize value = _value;
- (NSInteger)value {
    if (self.parentStats) {
        NSInteger minimum = -1;  // Sentinel value
        for (CharacterStat *parent in self.parentStats) {
            if (minimum == -1 || parent.value < minimum) {
                minimum = parent.value;
            }
        }
        _value = minimum;
    }
    return _value;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %d group:%d element:%d soul:%d", self.statName, self.value,
            self.groupMembership, self.elementMembership, self.soulMembership];
}

// This shouldn't be needed because <NSCopying> is not implemented - but it is a failsafe to prevent copying
// If ever I was to implement copying, it would need to relink the skill stats somehow
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

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

+ (CharacterStat *)createStat:(NSString *)statName
                 defaultValue:(NSInteger)startingStatValue
                        group:(t_CharacterStatGroup)groupStatBelongsTo
                      element:(t_CharacterStatElement)associatedElement
                         soul:(t_CharacterStatSoulLink)associatedSoulStat {
    CharacterStat *stat = [[CharacterStat alloc] init];
    stat.statName = statName;
    stat.value = startingStatValue;
    stat.groupMembership = groupStatBelongsTo;
    stat.elementMembership = associatedElement;
    stat.soulMembership = associatedSoulStat;
    return stat;
}

+ (CharacterStat *)createStat:(NSString *)statName
                  derivedFrom:(NSArray *)parentStats
                        group:(t_CharacterStatGroup)groupStatBelongsTo
                      element:(t_CharacterStatElement)associatedElement
                         soul:(t_CharacterStatSoulLink)associatedSoulStat {
    CharacterStat *stat = [CharacterStat createStat:statName
                                       defaultValue:0
                                              group:groupStatBelongsTo
                                            element:associatedElement
                                               soul:associatedSoulStat];
    stat.parentStats = parentStats;
    return stat;
}

// Warning - this should only be called once per Character
// (or, at least, there should only be one copy of this per character in existence at a time
+ (NSArray *)newCharacterStatsSet {
    
    // ---------- Soul ------------- //
    CharacterStat *body = [CharacterStat createStat:@"Body" defaultValue:2
                                              group:CharacterStatGroupSoul
                                            element:CharacterStatElementNone
                                               soul:CharacterStatSoulLinkBody];
    CharacterStat *mind = [CharacterStat createStat:@"Mind" defaultValue:2
                                              group:CharacterStatGroupSoul
                                            element:CharacterStatElementNone
                                               soul:CharacterStatSoulLinkMind];
    CharacterStat *spirit = [CharacterStat createStat:@"Spirit" defaultValue:2
                                                group:CharacterStatGroupSoul
                                              element:CharacterStatElementNone
                                                 soul:CharacterStatSoulLinkSpirit];
    
    // --------- Primary stats ---------- //
    
    CharacterStat *fire = [CharacterStat createStat:@"Ferocity" defaultValue:2
                                              group:CharacterStatGroupPrimary
                                            element:CharacterStatElementFire
                                               soul:CharacterStatSoulLinkNone];
    CharacterStat *air = [CharacterStat createStat:@"Precision" defaultValue:2
                                             group:CharacterStatGroupPrimary
                                           element:CharacterStatElementAir
                                              soul:CharacterStatSoulLinkNone];
    CharacterStat *water = [CharacterStat createStat:@"Agility" defaultValue:2
                                               group:CharacterStatGroupPrimary
                                             element:CharacterStatElementWater
                                                soul:CharacterStatSoulLinkNone];
    CharacterStat *earth = [CharacterStat createStat:@"Resilience" defaultValue:2
                                               group:CharacterStatGroupPrimary
                                             element:CharacterStatElementEarth
                                                soul:CharacterStatSoulLinkNone];
    CharacterStat *chi = [CharacterStat createStat:@"Chi" defaultValue:2
                                             group:CharacterStatGroupPrimary
                                           element:CharacterStatElementChi
                                              soul:CharacterStatSoulLinkNone];
    
    // ---------- Setup the array ------ //
    
    NSMutableArray *allStats = [[NSMutableArray alloc] initWithCapacity:50];
    [allStats addObjectsFromArray:@[body, mind, spirit, fire, air, water, earth, chi]];
    [allStats addObjectsFromArray:
     
     // --------- Skills --------------- //
     
     @[
     [CharacterStat createStat:@"Power, speed, lifting"
                   derivedFrom:@[body, fire]
                         group:CharacterStatGroupSkills
                       element:CharacterStatElementFire
                          soul:CharacterStatSoulLinkBody],
     [CharacterStat createStat:@"Instinct, innovation, insight, synthesis"
                   derivedFrom:@[mind, fire]
                         group:CharacterStatGroupSkills
                       element:CharacterStatElementFire
                          soul:CharacterStatSoulLinkMind],
     [CharacterStat createStat:@"Passion, agression, assertion, intimidation"
                   derivedFrom:@[spirit, fire]
                         group:CharacterStatGroupSkills
                       element:CharacterStatElementFire
                          soul:CharacterStatSoulLinkSpirit],
     
     [CharacterStat createStat:@"Craft, lockpicking"
                   derivedFrom:@[body, air]
                         group:CharacterStatGroupSkills
                       element:CharacterStatElementAir
                          soul:CharacterStatSoulLinkBody],
     [CharacterStat createStat:@"Logic, science, reasoning, investigation, memory"
                   derivedFrom:@[mind, air]
                         group:CharacterStatGroupSkills
                       element:CharacterStatElementAir
                          soul:CharacterStatSoulLinkMind],
     [CharacterStat createStat:@"Culture, disguise, trickery, cunning"
                   derivedFrom:@[spirit, air]
                         group:CharacterStatGroupSkills
                       element:CharacterStatElementAir
                          soul:CharacterStatSoulLinkSpirit],
     
     [CharacterStat createStat:@"Balance, stealth, reflexes"
                   derivedFrom:@[body, water]
                         group:CharacterStatGroupSkills
                       element:CharacterStatElementWater
                          soul:CharacterStatSoulLinkBody],
     [CharacterStat createStat:@"Language, interpretation"
                   derivedFrom:@[mind, water]
                         group:CharacterStatGroupSkills
                       element:CharacterStatElementWater
                          soul:CharacterStatSoulLinkMind],
     [CharacterStat createStat:@"Empathy, charm, misdirection"
                   derivedFrom:@[spirit, water]
                         group:CharacterStatGroupSkills
                       element:CharacterStatElementWater
                          soul:CharacterStatSoulLinkSpirit],
     
     [CharacterStat createStat:@"Fortitude, stamina, labour"
                   derivedFrom:@[body, earth]
                         group:CharacterStatGroupSkills
                       element:CharacterStatElementEarth
                          soul:CharacterStatSoulLinkBody],
     [CharacterStat createStat:@"Perception, observation, procedure, tracking"
                   derivedFrom:@[mind, earth]
                         group:CharacterStatGroupSkills
                       element:CharacterStatElementEarth
                          soul:CharacterStatSoulLinkMind],
     [CharacterStat createStat:@"Confidence, bravery, diligence, patience"
                   derivedFrom:@[spirit, earth]
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
                          soul:CharacterStatSoulLinkNone]
     ]
     ];
    return allStats;
}

@end
