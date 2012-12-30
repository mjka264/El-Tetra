//
//  CharacterDataModel.m
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterStatPresenter.h"

@interface CharacterStatPresenter ()
/*
- (NSNumber *)abilityValueWithDescription:(NSString *)description;
- (NSNumber *)primaryStatValueWithDescription:(NSString *)description;
*/

@property (nonatomic, strong) NSArray *allStats;
@end

@implementation CharacterStatPresenter

- (CharacterStat *)statMatchingDescription:(NSString *)description {
    __block CharacterStat *stat;
    [self.allStats enumerateObjectsUsingBlock:^(CharacterStat *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.description isEqualToString:description]) {
            stat = obj;
            *stop = YES;
        }
    }];
    return stat;
}

- (NSArray *)statsMatchingCriteriaGroup:(t_CharacterStatGroup)groupMembership
                                element:(t_CharacterStatElement)elementMembership
                                   soul:(t_CharacterStatSoulLink)soulMembership {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self.allStats enumerateObjectsUsingBlock:^(CharacterStat *obj, NSUInteger idx, BOOL *stop) {
        if (obj.groupMembership == groupMembership &&
            obj.elementMembership == elementMembership &&
            obj.soulMembership == elementMembership) {
            [array addObject:obj];
        }
    }];
    return [array copy];
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
    CharacterStat *stat = [[self statsMatchingCriteriaGroup:CharacterStatGroupPrimary
                                                    element:CharacterStatElementFire
                                                       soul:CharacterStatSoulLinkNone] lastObject];
    return [NSNumber numberWithInteger:stat.value];
}
- (NSNumber *)effectiveStatRawPrecision {
    CharacterStat *stat = [[self statsMatchingCriteriaGroup:CharacterStatGroupPrimary
                                                    element:CharacterStatElementAir
                                                       soul:CharacterStatSoulLinkNone] lastObject];
    return [NSNumber numberWithInteger:stat.value];
}
- (NSNumber *)effectiveStatDodge {
    CharacterStat *stat = [[self statsMatchingCriteriaGroup:CharacterStatGroupPrimary
                                                    element:CharacterStatElementWater
                                                       soul:CharacterStatSoulLinkNone] lastObject];
    return [NSNumber numberWithInteger:stat.value];
}
- (NSNumber *)effectiveStatSoak {
    CharacterStat *stat = [[self statsMatchingCriteriaGroup:CharacterStatGroupPrimary
                                                    element:CharacterStatElementEarth
                                                       soul:CharacterStatSoulLinkNone] lastObject];
    return [NSNumber numberWithInteger:stat.value];
}
- (NSNumber *)effectiveStatMagicDefense {
    CharacterStat *stat = [[self statsMatchingCriteriaGroup:CharacterStatGroupPrimary
                                                    element:CharacterStatElementChi
                                                       soul:CharacterStatSoulLinkNone] lastObject];
    return [NSNumber numberWithInteger:stat.value];
}

#pragma mark support for CharacterStatEditorTableViewController

- (NSArray *)getEditableStatsInGroups {
    NSMutableArray *soul = [[NSMutableArray alloc] init];
    NSMutableArray *primary = [[NSMutableArray alloc] init];
    NSMutableArray *ability = [[NSMutableArray alloc] init];
    [self.allStats enumerateObjectsUsingBlock:^(CharacterStat *obj, NSUInteger idx, BOOL *stop) {
        if (obj.groupMembership == CharacterStatGroupSoul) [soul addObject:obj];
        else if (obj.groupMembership == CharacterStatGroupPrimary) [primary addObject:obj];
        else if (obj.groupMembership == CharacterStatGroupSkills) [ability addObject:obj];
    }];
    return @[soul, primary, ability];
}
    
- (void)setStatWithDescription:(NSString *)description value:(NSInteger)value {
    CharacterStat *stat = [[self statsMatchingCriteriaGroup:CharacterStatGroupPrimary
                                                    element:CharacterStatElementEarth
                                                       soul:CharacterStatSoulLinkNone] lastObject];
    stat.value = value;
}



/*
@synthesize savedLookupKey = _dataGroupKey;




- (CharacterStatPresenter *)characterWithAllStats {
    return [self copy];
}

// Makes a copy of the class with the key saved for future lookups
- (CharacterStatPresenter *)characterWithStatGroup:(t_CharacterStatGroup)group {
    CharacterStatPresenter *data = [self copy];
    data.savedLookupKey = group;
    return data;
}

+ (NSInteger)numberOfStatGroupsFrom:(CharacterStatPresenter *)character {
    if (character.savedLookupKey) {
        return 1;
    } else {
        return [character.statDescriptions count];
    }
}

+ (NSInteger)numberOfEntriesFrom:(CharacterStatPresenter *)character {
    return [CharacterStatPresenter numberOfEntriesFrom:character inStatGroup:character.savedLookupKey];
}

+ (NSInteger)numberOfEntriesFrom:(CharacterStatPresenter *)character inStatGroup:(t_CharacterStatGroup)group {
    return [[character.statValues objectForKey:[NSNumber numberWithInt:group]] count];
}

+ (NSString *)sectionHeadingFrom:(CharacterStatPresenter *)character {
    return [CharacterStatPresenter sectionHeadingFrom:character inStatGroup:character.savedLookupKey];
}

+ (NSString *)sectionHeadingFrom:(CharacterStatPresenter *)character inStatGroup:(t_CharacterStatGroup)group {
    return [character.statGroupHeadings objectForKey:[NSNumber numberWithInt:group]];
}

+ (NSString *)statDescriptionFrom:(CharacterStatPresenter *)character atIndex:(NSInteger)index {
    return [CharacterStatPresenter statDescriptionFrom:character atIndex:index inStatGroup:character.savedLookupKey];
}

+ (NSString *)statDescriptionFrom:(CharacterStatPresenter *)character atIndex:(NSInteger)index inStatGroup:(t_CharacterStatGroup)group {
    return [[character.statDescriptions objectForKey:[NSNumber numberWithInt:group]] objectAtIndex:index];
}
            
+ (NSNumber *)statValueFrom:(CharacterStatPresenter *)character atIndex:(NSInteger)index {
    return [CharacterStatPresenter statValueFrom:character atIndex:index inStatGroup:character.savedLookupKey];
}

+ (NSNumber *)statValueFrom:(CharacterStatPresenter *)character atIndex:(NSInteger)index inStatGroup:(t_CharacterStatGroup)group {
    return [[character.statValues objectForKey:[NSNumber numberWithInt:group]] objectAtIndex:index];
}

+ (t_CharacterStatElement)statElementFrom:(CharacterStatPresenter *)character atIndex:(NSInteger)index {
    return [CharacterStatPresenter statElementFrom:character atIndex:index inStatGroup:character.savedLookupKey];
}

+ (t_CharacterStatElement)statElementFrom:(CharacterStatPresenter *)character atIndex:(NSInteger)index inStatGroup:(t_CharacterStatGroup)group {
    return [[[character.statElements objectForKey:[NSNumber numberWithInt:group]] objectAtIndex:index] integerValue];
}

+ (NSNumber *)primaryStatForSkillGroupFrom:(CharacterStatPresenter *)character {
    return [CharacterStatPresenter primaryStatForSkillGroupFrom:character inStatGroup:character.savedLookupKey];
}

// BUG: rewrite this with strings not indexes
// Also, #define those strings within this file
+ (NSNumber *)primaryStatForSkillGroupFrom:(CharacterStatPresenter *)character inStatGroup:(t_CharacterStatGroup)group {
    NSInteger index = 0;
    if (group == CharacterStatGroupFireSkills) index = 0;
    else if (group == CharacterStatGroupAirSkills) index = 1;
    else if (group == CharacterStatGroupWaterSkills) index = 2;
    else if (group == CharacterStatGroupEarthSkills) index = 3;
    else if (group == CharacterStatGroupChiSkills) index = 4;
    
    return [[character.statValues objectForKey:[NSNumber numberWithInt:CharacterStatGroupPrimary]] objectAtIndex:index];
}

+ (NSNumber *)soulStatFrom:(CharacterStatPresenter *)character forStat:(t_CharacterStatSoul)stat {
    NSInteger index = 0;
    if (stat == CharacterStatSoulBody) index = 0;
    else if (stat == CharacterStatSoulMind) index = 1;
    else if (stat == CharacterStatSoulSpirit) index = 2;
    
    return [[character.statValues objectForKey:[NSNumber numberWithInt:CharacterStatGroupSoul]] objectAtIndex:index];

}


+ (t_CharacterStatElement)statElementforHeadingFrom:(CharacterStatPresenter *)characterData {
    switch (characterData.savedLookupKey) {
        case CharacterStatGroupFireSkills:
            return CharacterStatElementFire;
        case CharacterStatGroupAirSkills:
            return CharacterStatElementAir;
        case CharacterStatGroupWaterSkills:
            return CharacterStatElementWater;
        case CharacterStatGroupEarthSkills:
            return CharacterStatElementEarth;
        case CharacterStatGroupChiSkills:
            return CharacterStatElementChi;
        default:
            return 0;
    }
}

// This depends on the enum for t_characterDataStatGroup starting at 1 and being in order
+ (NSInteger)dataStatGroupForSectionNumber:(NSInteger)index {
    return index + 1;
}

- (id)copyWithZone:(NSZone *)zone
{
	CharacterStatPresenter *copy = [[CharacterStatPresenter allocWithZone: zone] init];
    copy.statDescriptions = self.statDescriptions;
    copy.statValues = self.statValues;
    copy.statElements = self.statElements;
    return copy;
}


- (NSNumber *)abilityValueWithDescription:(NSString *)description {
    NSInteger index = [((NSArray *)[self.statDescriptions objectForKey:[NSNumber numberWithInt:CharacterStatGroupAbilities]]) indexOfObject:description];
    return [[self.statValues objectForKey:[NSNumber numberWithInt:CharacterStatGroupAbilities]] objectAtIndex:index];
}

- (NSNumber *)primaryStatValueWithDescription:(NSString *)description {
    NSInteger index = [((NSArray *)[self.statDescriptions objectForKey:[NSNumber numberWithInt:CharacterStatGroupPrimary]]) indexOfObject:description];
    return [[self.statValues objectForKey:[NSNumber numberWithInt:CharacterStatGroupPrimary]] objectAtIndex:index];
}

// BUG the strings below need to be #defined


+ (NSArray *)editableStatGroupsFrom:(CharacterStatPresenter *)character {
    return @[
    [NSNumber numberWithInteger:CharacterStatGroupSoul],
    [NSNumber numberWithInteger:CharacterStatGroupPrimary],
    [NSNumber numberWithInteger:CharacterStatGroupAbilities]];
}

+ (void)setStatValueFrom:(CharacterStatPresenter *)character atIndex:(NSInteger)index inStatGroup:(t_CharacterStatGroup)group to:(NSInteger)value {
    NSMutableArray *array = [character.statValues objectForKey:[NSNumber numberWithInt:group]];
    [array replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:value]];
}

+ (NSInteger)statCostFor:(id)character atIndex:(NSInteger)index inStatGroup:(t_CharacterStatGroup)group {
    if (group == CharacterStatGroupSoul) return 3;
    else if (group == CharacterStatGroupPrimary) return 2;
    else if (group == CharacterStatGroupAbilities) {
        t_CharacterStatElement element = [CharacterStatPresenter statElementFrom:character atIndex:index inStatGroup:group];
        if (element == CharacterStatElementAir ||
            element == CharacterStatElementFire ||
            element == CharacterStatElementWater ||
            element == CharacterStatElementEarth ||
            element == CharacterStatElementChi) {
            return 1;
        } else {
            return 2;
        }
    }
    return 0;
}

+ (NSInteger)statCostFor:(id)character {
    NSInteger cost = 0;
    for (NSNumber *group in @[
         [NSNumber numberWithInteger:CharacterStatGroupSoul],
         [NSNumber numberWithInteger:CharacterStatGroupPrimary],
         [NSNumber numberWithInteger:CharacterStatGroupFireSkills],
         [NSNumber numberWithInteger:CharacterStatGroupAirSkills],
         [NSNumber numberWithInteger:CharacterStatGroupWaterSkills],
         [NSNumber numberWithInteger:CharacterStatGroupEarthSkills],
         [NSNumber numberWithInteger:CharacterStatGroupAbilities],
         [NSNumber numberWithInteger:CharacterStatGroupChiSkills]]) {
        for (int index = 0; index < [CharacterStatPresenter numberOfEntriesFrom:character inStatGroup:[group integerValue]]  ; index ++) {
            cost +=
            [[CharacterStatPresenter statValueFrom:character atIndex:index inStatGroup:[group integerValue]] integerValue] *
            [CharacterStatPresenter statCostFor:character atIndex:index inStatGroup:[group integerValue]];
        }
    }
    return cost;
}
*/


@end
