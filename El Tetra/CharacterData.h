//
//  CharacterDataModel.h
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <Foundation/Foundation.h>

// The implementation of dataStatGroupWhenDisplayingAllForIndex depends on this list starting at 0
typedef enum {
    CharacterDataStatGroupSoul = 0,
    CharacterDataStatGroupPrimary = 1,
    CharacterDataStatGroupFireSkills = 2,
    CharacterDataStatGroupAirSkills = 3,
    CharacterDataStatGroupWaterSkills = 4,
    CharacterDataStatGroupEarthSkills = 5,
    CharacterDataStatGroupAbilities = 6
} t_characterDataStatGroup;

typedef enum {
    CharacterDataElementFire = 0,
    CharacterDataElementAir = 1,
    CharacterDataElementWater = 2,
    CharacterDataElementEarth = 3,
    CharacterDataElementChi = 4,
    CharacterDataElementFireChi = 5,
    CharacterDataElementAirChi = 6,
    CharacterDataElementWaterChi = 7,
    CharacterDataElementEarthChi = 8,
} t_characterDataElement;

// The (id) returned by the first two methods is the parameter to these other methods
@interface CharacterData : NSObject <NSCopying>
- (id)characterWithAllStats;
- (id)characterWithStatGroup:(t_characterDataStatGroup)group;
+ (NSInteger)numberOfStatGroupsFrom:(id)characterData;
+ (NSInteger)numberOfEntriesFrom:(id)characterData;
+ (NSInteger)numberOfEntriesFrom:(id)characterData inStatGroup:(t_characterDataElement)group;
+ (NSString *)sectionHeadingFrom:(id)characterData;
+ (NSString *)sectionHeadingFrom:(id)characterData inStatGroup:(t_characterDataElement)group;
+ (NSString *)statDescriptionFrom:(id)characterData atIndex:(NSInteger)index;
+ (NSString *)statDescriptionFrom:(id)characterData atIndex:(NSInteger)index inStatGroup:(t_characterDataElement)group;
+ (NSNumber *)statValueFrom:(id)characterData atIndex:(NSInteger)index;
+ (NSNumber *)statValueFrom:(id)characterData atIndex:(NSInteger)index inStatGroup:(t_characterDataElement)group;
+ (t_characterDataElement)statElementFrom:(id)characterData atIndex:(NSInteger)index;
+ (t_characterDataElement)statElementFrom:(id)characterData atIndex:(NSInteger)index inStatGroup:(t_characterDataElement)group;
+ (t_characterDataElement)statElementforHeadingFrom:(id)characterData;
+ (NSInteger)dataStatGroupForSectionNumber:(NSInteger)index;

@end










