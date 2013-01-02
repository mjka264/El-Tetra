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

@end










