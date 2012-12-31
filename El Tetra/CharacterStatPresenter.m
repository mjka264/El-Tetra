//
//  CharacterDataModel.m
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterStatPresenter.h"

@interface CharacterStatPresenter ()
@end

BOOL characterStatElementIsDualElement(t_CharacterStatElement element) {
    return (element == CharacterStatElementAirChi ||
            element == CharacterStatElementEarthChi ||
            element == CharacterStatElementFireChi ||
            element == CharacterStatElementWaterChi);
}

t_CharacterStatElement characterStatGreekElement(t_CharacterStatElement element) {
    if (element == CharacterStatElementAirChi) return CharacterStatElementAir;
    else if (element == CharacterStatElementEarthChi) return CharacterStatElementEarth;
    else if (element == CharacterStatElementFireChi) return CharacterStatElementFire;
    else if (element == CharacterStatElementWaterChi) return CharacterStatElementWater;
    else return element;
}

@implementation CharacterStatPresenter
@synthesize allStats = _allStats;
- (NSArray *)allStats {
    if (!_allStats) _allStats = [CharacterStat newCharacterStatsSet];
    return _allStats;
}
@synthesize headingStat = _headingStat;

- (NSString *)description {
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (CharacterStat *stat in self.allStats) {
        [data addObject:[NSString stringWithFormat:@"%d", stat.value]];
    }
    if ([data count]) {
        return [data componentsJoinedByString:@","];
    } else {
        return @"-empty-";
    }
}

- (CharacterStat *)statMatchingDescription:(NSString *)description {
    __block CharacterStat *stat;
    [self.allStats enumerateObjectsUsingBlock:^(CharacterStat *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.statName isEqualToString:description]) {
            stat = obj;
            *stop = YES;
        }
    }];
    return stat;
}

- (CharacterStat *)statMatchingCriteriaGroup:(t_CharacterStatGroup)groupMembership
                                     element:(t_CharacterStatElement)elementMembership
                                        soul:(t_CharacterStatSoulLink)soulMembership {
    for (CharacterStat *stat in self.allStats) {
        if ((groupMembership == 0 || stat.groupMembership == groupMembership) &&
            (elementMembership == 0 || stat.elementMembership == elementMembership) &&
            (soulMembership == 0 || stat.soulMembership == elementMembership)) {
            return stat;
        }
    }
    return nil;
}

- (CharacterStatPresenter *)statPresenterMatchingCriteriaGroup:(t_CharacterStatGroup)groupMembership
                                                       element:(t_CharacterStatElement)elementMembership
                                                          soul:(t_CharacterStatSoulLink)soulMembership
                                            includeHeadingStat:(BOOL)headingStat {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (CharacterStat *obj in self.allStats) {
        if ((groupMembership == 0 || obj.groupMembership == groupMembership) &&
            (elementMembership == 0 || obj.elementMembership == elementMembership) &&
            (soulMembership == 0 || obj.soulMembership == soulMembership)) {
            [array addObject:obj];
        }
    }
    CharacterStatPresenter *presenter = [[CharacterStatPresenter alloc] init];
    presenter.allStats = array;
    if (headingStat && (groupMembership != CharacterStatGroupSkills))
        [NSException raise:@"This function should only be called with Skills" format:@"group:%d", groupMembership];
    else if (headingStat) {
        presenter.headingStat = [self statMatchingCriteriaGroup:CharacterStatGroupPrimary
                                                        element:elementMembership soul:0];
    }
    return presenter;
}

- (CharacterStatPresenter *)statPresenterWithStatMatchingCriteriaGroup:(t_CharacterStatGroup)groupMembership
                                                               element:(t_CharacterStatElement)elementMembership
                                                                  soul:(t_CharacterStatSoulLink)soulMembership
                                                    includeHeadingStat:(BOOL)headingStat
{
    CharacterStatPresenter *presenter = [[CharacterStatPresenter alloc] init];
    presenter.allStats = @[[self statMatchingCriteriaGroup:groupMembership element:elementMembership soul:soulMembership]];
    if (headingStat && (groupMembership != CharacterStatGroupSkills))
        [NSException raise:@"This function should only be called with Skills" format:@"group:%d", groupMembership];
    else if (headingStat) {
        presenter.headingStat = [self statMatchingCriteriaGroup:CharacterStatGroupPrimary
                                                        element:elementMembership soul:0];
    }
    return presenter;
}


#pragma mark CharacterLoadoutAssistsDerivation protocol

- (NSNumber *)effectiveStatInitiative {
    return [NSNumber numberWithInteger:[self statMatchingDescription:STAT_INITIATIVE].value];
}
- (NSNumber *)effectiveStatAttackArtful {
    return [NSNumber numberWithInteger:[self statMatchingDescription:STAT_ARTFUL].value];
}
- (NSNumber *)effectiveStatAttackBrutal {
    return [NSNumber numberWithInteger:[self statMatchingDescription:STAT_BRUTAL].value];
}
- (NSNumber *)effectiveStatAttackProjectile {
    return [NSNumber numberWithInteger:[self statMatchingDescription:STAT_PROJECTILE].value];
}
- (NSNumber *)effectiveStatDamage {
    CharacterStat *stat = [self statMatchingCriteriaGroup:CharacterStatGroupPrimary
                                                  element:CharacterStatElementFire
                                                     soul:CharacterStatSoulLinkNone];
    return [NSNumber numberWithInteger:stat.value];
}
- (NSNumber *)effectiveStatRawPrecision {
    CharacterStat *stat = [self statMatchingCriteriaGroup:CharacterStatGroupPrimary
                                                  element:CharacterStatElementAir
                                                     soul:CharacterStatSoulLinkNone];
    return [NSNumber numberWithInteger:stat.value];
}
- (NSNumber *)effectiveStatDodge {
    CharacterStat *stat = [self statMatchingCriteriaGroup:CharacterStatGroupPrimary
                                                  element:CharacterStatElementWater
                                                     soul:CharacterStatSoulLinkNone];
    return [NSNumber numberWithInteger:stat.value];
}
- (NSNumber *)effectiveStatSoak {
    CharacterStat *stat = [self statMatchingCriteriaGroup:CharacterStatGroupPrimary
                                                  element:CharacterStatElementEarth
                                                     soul:CharacterStatSoulLinkNone];
    return [NSNumber numberWithInteger:stat.value];
}
- (NSNumber *)effectiveStatMagicDefense {
    CharacterStat *stat = [self statMatchingCriteriaGroup:CharacterStatGroupPrimary
                                                  element:CharacterStatElementChi
                                                     soul:CharacterStatSoulLinkNone];
    return [NSNumber numberWithInteger:stat.value];
}

#pragma mark support for CharacterStatEditorTableViewController

+ (NSString *)headingForGroup:(t_CharacterStatGroup)group {
    NSString *str;
    if (group == CharacterStatGroupSoul) str = @"Expression";
    else if (group == CharacterStatGroupPrimary) str = @"Primary Stats";
    else if (group == CharacterStatGroupAbilities) str = @"Abilities";
    return str;
}

+ (NSString *)headingForElement:(t_CharacterStatElement)element {
    NSString *str;
    if (element == CharacterStatElementFire) str = @"Fire";
    else if (element == CharacterStatElementAir) str = @"Air";
    else if (element == CharacterStatElementWater) str = @"Water";
    else if (element == CharacterStatElementEarth) str = @"Earth";
    else if (element == CharacterStatElementChi) str = @"Chi";
    else if (element == CharacterStatElementFireChi) str = @"Fire Chi";
    else if (element == CharacterStatElementAirChi) str = @"Air Chi";
    else if (element == CharacterStatElementWaterChi) str = @"Water Chi";
    else if (element == CharacterStatElementEarthChi) str = @"Earth Chi";
    return str;
}

- (NSArray *)getEditableStatsInGroups {
    NSMutableArray *soul = [[NSMutableArray alloc] init];
    NSMutableArray *primary = [[NSMutableArray alloc] init];
    NSMutableArray *ability = [[NSMutableArray alloc] init];
    for (CharacterStat *stat in self.allStats) {
        if (stat.groupMembership == CharacterStatGroupSoul) [soul addObject:stat];
        else if (stat.groupMembership == CharacterStatGroupPrimary) [primary addObject:stat];
        else if (stat.groupMembership == CharacterStatGroupAbilities) [ability addObject:stat];
    }
    return @[soul, primary, ability];
}
    
- (void)setStatWithDescription:(NSString *)description value:(NSInteger)value {
    CharacterStat *stat = [self statMatchingDescription:description];
    stat.value = value;
}

- (NSInteger)totalStatCost {
    NSInteger total = 0;
    for (CharacterStat *stat in self.allStats) {
        total += stat.skillCost * stat.value;
    }
    return total;
}

@end
