//
//  CharacterDataModel.h
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CharacterLoadout.h"

// The implementation of dataStatGroupWhenDisplayingAllForIndex depends on this list starting at 1
typedef enum {
    CharacterStatGroupSoul = 1,
    CharacterStatGroupPrimary = 2,
    CharacterStatGroupFireSkills = 3,
    CharacterStatGroupAirSkills = 4,
    CharacterStatGroupWaterSkills = 5,
    CharacterStatGroupEarthSkills = 6,
    CharacterStatGroupAbilities = 7,
    CharacterStatGroupChiSkills = 99
} t_CharacterStatGroup;

typedef enum {
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
    CharacterStatSoulBody = 1,
    CharacterStatSoulMind = 2,
    CharacterStatSoulSpirit = 3
} t_CharacterStatSoul;

// The (id) returned by the first two methods is the parameter to these other methods
@interface CharacterStats : NSObject <NSCopying,CharacterLoadoutAssistsDerivation>
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
@end










