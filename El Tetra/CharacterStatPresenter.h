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
    CharacterStatGroupNone,
    CharacterStatGroupSoul,
    CharacterStatGroupPrimary,
    CharacterStatGroupSkills,
    CharacterStatGroupAbilities
} t_CharacterStatGroup;

typedef enum {
    CharacterStatElementNone,
    CharacterStatElementFire,
    CharacterStatElementAir,
    CharacterStatElementWater,
    CharacterStatElementEarth,
    CharacterStatElementChi,
    CharacterStatElementFireChi,
    CharacterStatElementAirChi,
    CharacterStatElementWaterChi,
    CharacterStatElementEarthChi,
} t_CharacterStatElement;

BOOL characterStatElementIsDualElement(t_CharacterStatElement element);
t_CharacterStatElement characterStatGreekElement(t_CharacterStatElement element);

typedef enum {
    CharacterStatSoulLinkNone,
    CharacterStatSoulLinkBody,
    CharacterStatSoulLinkMind,
    CharacterStatSoulLinkSpirit
} t_CharacterStatSoulLink;

@interface CharacterStatPresenter : NSObject <CharacterLoadoutAssistsDerivation>
@property (nonatomic, strong) NSArray *allStats;
@property (nonatomic, strong) CharacterStat *headingStat;

- (CharacterStat *)statMatchingDescription:(NSString *)description;                 // returns a CharacterStat
- (CharacterStat *)statMatchingCriteriaGroup:(t_CharacterStatGroup)groupMembership
                                     element:(t_CharacterStatElement)elementMembership
                                        soul:(t_CharacterStatSoulLink)soulMembership;
- (CharacterStatPresenter *)statPresenterMatchingCriteriaGroup:(t_CharacterStatGroup)groupMembership
                                                       element:(t_CharacterStatElement)elementMembership
                                                          soul:(t_CharacterStatSoulLink)soulMembership
                                            includeHeadingStat:(BOOL)yesOrNo;
- (CharacterStatPresenter *)statPresenterWithStatMatchingCriteriaGroup:(t_CharacterStatGroup)groupMembership
                                                               element:(t_CharacterStatElement)elementMembership
                                                                  soul:(t_CharacterStatSoulLink)soulMembership
                                                    includeHeadingStat:(BOOL)yesOrNo;

    - (NSArray *)allStats;

// This is for CharacterStatEditorTableViewController
+ (NSString *)headingForGroup:(t_CharacterStatGroup)group;
+ (NSString *)headingForElement:(t_CharacterStatElement)element;

- (NSArray *)getEditableStatsInGroups;  // returns a 2d array for presentation
- (void)setStatWithDescription:(NSString *)stat value:(NSInteger)value;
- (NSInteger)totalStatCost;


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










