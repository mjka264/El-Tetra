//
//  CharacterDataModel.h
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CharacterLoadout.h"
#import "CharacterStat.h"

typedef enum {
    CharacterStatGroupNone = 0,
    CharacterStatGroupSoul = 1,
    CharacterStatGroupPrimary = 2,
    CharacterStatGroupSkills = 3,
    CharacterStatGroupAbilities = 4,
} t_CharacterStatGroup;

typedef enum {
    CharacterStatElementNone = 0,
    CharacterStatElementFire = 1,
    CharacterStatElementAir = 2,
    CharacterStatElementWater = 3,
    CharacterStatElementEarth = 4,
    CharacterStatElementChi = 5,
    CharacterStatElementFireChi = 6,
    CharacterStatElementAirChi = 7,
    CharacterStatElementWaterChi = 8,
    CharacterStatElementEarthChi = 9,
} t_CharacterStatElement;

typedef enum {
    CharacterStatSoulLinkNone = 0,
    CharacterStatSoulLinkBody = 1,
    CharacterStatSoulLinkMind = 2,
    CharacterStatSoulLinkSpirit = 3
} t_CharacterStatSoulLink;

@interface CharacterStatPresenter : NSObject <NSCopying, CharacterLoadoutAssistsDerivation>
- (CharacterStat *)statMatchingDescription:(NSString *)description;                 // returns a CharacterStat
- (NSArray *)statsMatchingCriteriaGroup:(t_CharacterStatGroup)groupMembership
                                element:(t_CharacterStatElement)elementMembership
                                   soul:(t_CharacterStatSoulLink)soulMembership;    // returns array of CharacterStat

// This is for CharacterStatEditorTableViewController
- (NSArray *)getEditableStatsInGroups;  // returns a 2d array for presentation
- (void)setStatWithDescription:(NSString *)stat value:(NSInteger)value;

/*

// The interface for view controller that have read-only access to the stats
// The (id) returned by the first two methods is the parameter to these other methods
- (id)characterWithAllStats;
- (id)characterWithStatGroup:(t_CharacterStatGroup)group;
+ (NSInteger)numberOfStatGroupsFrom:(id)characterData;
+ (NSInteger)numberOfEntriesFrom:(id)characterData;
+ (NSInteger)numberOfEntriesFrom:(id)characterData inStatGroup:(t_CharacterStatGroup)group;
+ (NSString *)sectionHeadingFrom:(id)characterData;
+ (NSString *)sectionHeadingFrom:(id)characterData inStatGroup:(t_CharacterStatGroup)group;
+ (NSString *)statDescriptionFrom:(id)characterData atIndex:(NSInteger)index;
+ (NSString *)statDescriptionFrom:(id)characterData atIndex:(NSInteger)index inStatGroup:(t_CharacterStatGroup)group;
+ (NSNumber *)statValueFrom:(id)characterData atIndex:(NSInteger)index;
+ (NSNumber *)statValueFrom:(id)characterData atIndex:(NSInteger)index inStatGroup:(t_CharacterStatGroup)group;
+ (t_CharacterStatElement)statElementFrom:(id)characterData atIndex:(NSInteger)index;
+ (t_CharacterStatElement)statElementFrom:(id)characterData atIndex:(NSInteger)index inStatGroup:(t_CharacterStatGroup)group;
+ (t_CharacterStatElement)statElementforHeadingFrom:(id)characterData;
+ (NSInteger)dataStatGroupForSectionNumber:(NSInteger)index;
+ (NSNumber *)primaryStatForSkillGroupFrom:(id)characterData;
+ (NSNumber *)primaryStatForSkillGroupFrom:(id)characterData inStatGroup:(t_CharacterStatGroup)group;
+ (NSNumber *)soulStatFrom:(id)characterData forStat:(t_CharacterStatSoul)stat;

// The interface for view controllers that have write access to the data
+ (NSArray *)editableStatGroupsFrom:(id)characterData;  // of NSNumber representing the data in the enum
+ (void)setStatValueFrom:(id)characterData atIndex:(NSInteger)index inStatGroup:(t_CharacterStatGroup)group to:(NSInteger)value;
+ (NSInteger)statCostFor:(id)characterData atIndex:(NSInteger)index inStatGroup:(t_CharacterStatGroup)group;
+ (NSInteger)statCostFor:(id)characterData;
*/
@end










