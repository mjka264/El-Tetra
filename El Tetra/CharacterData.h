//
//  CharacterDataModel.h
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CharacterDataStatGroupSoul = 1,
    CharacterDataStatGroupPrimary = 2,
    CharacterDataStatGroupFireSkills = 3,
    CharacterDataStatGroupAirSkills = 4,
    CharacterDataStatGroupWaterSkills = 5,
    CharacterDataStatGroupEarthSkills = 6,
    CharacterDataStatGroupAbilities = 7
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

//typedef NSString* t_characterData;

@interface CharacterData : NSObject
- (id)dataWithAllStats;
- (id)dataWithStatGroup:(t_characterDataStatGroup)group;
+ (NSString *)headingFrom:(id)characterData;
+ (NSInteger)numberOfSectionsFrom:(id)characterData;
+ (NSString *)numberOfEntriesFrom:(id)characterData atSection:(NSInteger)section;
+ (NSString *)sectionHeadingFrom:(id)characterData atSection:(NSInteger)section;
+ (NSString *)itemDescriptionFrom:(id)characterData atIndexPath:(NSIndexPath *)indexPath;
+ (NSNumber *)itemValueFrom:(id)characterData atIndexPath:(NSIndexPath *)indexPath;
+ (t_characterDataElement)itemElementFrom:(id)characterData atIndexPath:(NSIndexPath *)indexPath;
@end










