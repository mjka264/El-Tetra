//
//  CharacterDataModel.h
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <Foundation/Foundation.h>

// The implementation of dataStatGroupWhenDisplayingAllForIndex depends on this list starting at 1
typedef enum {
    CharacterDataStatGroupSoul = 1,
    CharacterDataStatGroupPrimary = 2,
    CharacterDataStatGroupFireSkills = 3,
    CharacterDataStatGroupAirSkills = 4,
    CharacterDataStatGroupWaterSkills = 5,
    CharacterDataStatGroupEarthSkills = 6,
    CharacterDataStatGroupAbilities = 7,
    CharacterDataStatGroupChiSkills = 99
} t_characterDataStatGroup;

typedef enum {
    CharacterDataElementFire = 1,
    CharacterDataElementAir = 2,
    CharacterDataElementWater = 3,
    CharacterDataElementEarth = 4,
    CharacterDataElementChi = 5,
    CharacterDataElementFireChi = 6,
    CharacterDataElementAirChi = 7,
    CharacterDataElementWaterChi = 8,
    CharacterDataElementEarthChi = 9,
} t_characterDataElement;

typedef enum {
    CharacterDataSoulStatBody = 1,
    CharacterDataSoulStatMind = 2,
    CharacterDataSoulStatSpirit = 3
} t_characterDataSoulStat;

// The (id) returned by the first two methods is the parameter to these other methods
@interface CharacterData : NSObject <NSCopying>
- (id)characterWithAllStats;
- (id)characterWithStatGroup:(t_characterDataStatGroup)group;
+ (NSInteger)numberOfStatGroupsFrom:(id)characterData;
+ (NSInteger)numberOfEntriesFrom:(id)characterData;
+ (NSInteger)numberOfEntriesFrom:(id)characterData inStatGroup:(t_characterDataStatGroup)group;
+ (NSString *)sectionHeadingFrom:(id)characterData;
+ (NSString *)sectionHeadingFrom:(id)characterData inStatGroup:(t_characterDataStatGroup)group;
+ (NSString *)statDescriptionFrom:(id)characterData atIndex:(NSInteger)index;
+ (NSString *)statDescriptionFrom:(id)characterData atIndex:(NSInteger)index inStatGroup:(t_characterDataStatGroup)group;
+ (NSNumber *)statValueFrom:(id)characterData atIndex:(NSInteger)index;
+ (NSNumber *)statValueFrom:(id)characterData atIndex:(NSInteger)index inStatGroup:(t_characterDataStatGroup)group;
+ (t_characterDataElement)statElementFrom:(id)characterData atIndex:(NSInteger)index;
+ (t_characterDataElement)statElementFrom:(id)characterData atIndex:(NSInteger)index inStatGroup:(t_characterDataStatGroup)group;
+ (t_characterDataElement)statElementforHeadingFrom:(id)characterData;
+ (NSInteger)dataStatGroupForSectionNumber:(NSInteger)index;
+ (NSNumber *)primaryStatForSkillGroupFrom:(id)characterData;
+ (NSNumber *)primaryStatForSkillGroupFrom:(id)characterData inStatGroup:(t_characterDataStatGroup)group;
+ (NSNumber *)soulStatFrom:(id)characterData forStat:(t_characterDataSoulStat)stat;
@end










