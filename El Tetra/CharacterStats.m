//
//  CharacterDataModel.m
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterStats.h"

@interface CharacterStats ()
// These two dictionaries are each dictionaries of non-mutable arrays
// They are accessed using the t_characterDataStatGroup keys (in .h) and correspond to one another
@property (nonatomic, strong) NSDictionary *statDescriptions;    // of arrays
@property (nonatomic, strong) NSDictionary *statValues;          // of arrays
@property (nonatomic, strong) NSDictionary *statGroupHeadings;   // of strings

// This is the same as the above, although it currently only has data under the element key
@property (nonatomic, strong) NSDictionary *statElements;     // of arrays

// When a Character Data is passed as an ID, this property allows it to work out what was searched for
@property (nonatomic) NSInteger savedLookupKey;


@end


@implementation CharacterStats

@synthesize statGroupHeadings = _statGroupHeadings;
- (NSDictionary *)statGroupHeadings {
    if (!_statGroupHeadings) {
        _statGroupHeadings =
        [NSDictionary dictionaryWithObjectsAndKeys:
         @"Soul", [NSNumber numberWithInt:CharacterStatGroupSoul],
         @"Primary Stats", [NSNumber numberWithInt:CharacterStatGroupPrimary],
         @"Ferocity", [NSNumber numberWithInt:CharacterStatGroupFireSkills],
         @"Precision", [NSNumber numberWithInt:CharacterStatGroupAirSkills],
         @"Agility", [NSNumber numberWithInt:CharacterStatGroupWaterSkills],
         @"Resilience", [NSNumber numberWithInt:CharacterStatGroupEarthSkills],
         @"Chi", [NSNumber numberWithInt:CharacterStatGroupChiSkills],
         @"Abilities", [NSNumber numberWithInt:CharacterStatGroupAbilities], nil];
    }
    return _statGroupHeadings;
}

@synthesize statDescriptions = _statDescriptions;
- (NSDictionary *)statDescriptions {
    if (!_statDescriptions) {
        _statDescriptions =
        [NSDictionary dictionaryWithObjectsAndKeys:
         [NSArray arrayWithObjects:@"Body", @"Mind", @"Spirit", nil],
         [NSNumber numberWithInt:CharacterStatGroupSoul],
         
         // The order of these stats is hardcoded below in the function primaryStatForSkillGroupFrom
         // If the order changes here, it needs to change there too
         [NSArray arrayWithObjects:@"Ferocity", @"Accuracy", @"Agility", @"Resilience", @"Chi", nil],
         [NSNumber numberWithInt:CharacterStatGroupPrimary],
         
         [NSArray arrayWithObjects:
          @"Power, speed, lifting",
          @"Instinct, innovation, insight, synthesis",
          @"Passion, agression, assertion, intimidation", nil],
         [NSNumber numberWithInt:CharacterStatGroupFireSkills],
         
         [NSArray arrayWithObjects:
          @"Craft, lockpicking",
          @"Logic, science, reasoning, investigation, memory",
          @"Culture, disguise, trickery, cunning", nil],
         [NSNumber numberWithInt:CharacterStatGroupAirSkills],
         
         [NSArray arrayWithObjects:
          @"Balance, stealth, reflexes",
          @"Language, interpretation",
          @"Empathy, charm, misdirection", nil],
         [NSNumber numberWithInt:CharacterStatGroupWaterSkills],
         
         [NSArray arrayWithObjects:
          @"Fortitude, stamina, labour",
          @"Perception, observation, procedure, tracking",
          @"Confidence, bravery, diligence, patience", nil],
         [NSNumber numberWithInt:CharacterStatGroupEarthSkills],
         
         [NSArray arrayWithObjects:
          @"Rend", @"Spellsword",
          @"Artful weapons", @"Brutal weapons", @"Critical strikes", @"Projectile weapons",
          @"Initiative", @"Leap/float", @"Multiple attacks",
          @"Defensive pause", @"Strength within",
          @"Daoism", @"Shifting (body)", @"Shifting (mind, spirit)", @"Offworld contact",
          @"Primal fire", @"Primal air", @"Primal water", @"Primal earth", nil],
         [NSNumber numberWithInt:CharacterStatGroupAbilities],
         nil];
    }
    return _statDescriptions;
}

@synthesize statElements = _statElements;
- (NSDictionary *)statElements {
    if (!_statElements) {
        _statElements =
        [NSDictionary dictionaryWithObjectsAndKeys:
         [NSArray arrayWithObjects:
          [NSNumber numberWithInt: CharacterStatElementFire], [NSNumber numberWithInt: CharacterStatElementFire],
          [NSNumber numberWithInt: CharacterStatElementAir], [NSNumber numberWithInt: CharacterStatElementAir], [NSNumber numberWithInt: CharacterStatElementAir], [NSNumber numberWithInt: CharacterStatElementAir],
          [NSNumber numberWithInt: CharacterStatElementWater], [NSNumber numberWithInt: CharacterStatElementWater], [NSNumber numberWithInt: CharacterStatElementWater],
          [NSNumber numberWithInt: CharacterStatElementEarth], [NSNumber numberWithInt: CharacterStatElementEarth],
          [NSNumber numberWithInt: CharacterStatElementChi], [NSNumber numberWithInt: CharacterStatElementChi], [NSNumber numberWithInt: CharacterStatElementChi], [NSNumber numberWithInt: CharacterStatElementChi],
          [NSNumber numberWithInt: CharacterStatElementFireChi], [NSNumber numberWithInt: CharacterStatElementAirChi], [NSNumber numberWithInt: CharacterStatElementWaterChi], [NSNumber numberWithInt: CharacterStatElementEarthChi],
          nil],
         [NSNumber numberWithInt:CharacterStatGroupAbilities],
         nil];
    }
    return _statElements;
}

@synthesize statValues = _statValues;
- (NSDictionary *)statValues {
    if (!_statValues) {
        _statValues =
        [NSDictionary dictionaryWithObjectsAndKeys:
         [NSArray arrayWithObjects:
          [NSNumber numberWithInt:5],
          [NSNumber numberWithInt:3],
          [NSNumber numberWithInt:11], nil],
         [NSNumber numberWithInt:CharacterStatGroupSoul],
         
         [NSArray arrayWithObjects:
          [NSNumber numberWithInt:8],
          [NSNumber numberWithInt:3],
          [NSNumber numberWithInt:7],
          [NSNumber numberWithInt:3],
          [NSNumber numberWithInt:4], nil],
         [NSNumber numberWithInt:CharacterStatGroupPrimary],
         
         [NSArray arrayWithObjects:
          [NSNumber numberWithInt:5],
          [NSNumber numberWithInt:3],
          [NSNumber numberWithInt:4], nil],
         [NSNumber numberWithInt:CharacterStatGroupFireSkills],
         
         [NSArray arrayWithObjects:
          [NSNumber numberWithInt:6],
          [NSNumber numberWithInt:3],
          [NSNumber numberWithInt:4], nil],
         [NSNumber numberWithInt:CharacterStatGroupAirSkills],
         
         [NSArray arrayWithObjects:
          [NSNumber numberWithInt:7],
          [NSNumber numberWithInt:3],
          [NSNumber numberWithInt:4], nil],
         [NSNumber numberWithInt:CharacterStatGroupWaterSkills],
         
         [NSArray arrayWithObjects:
          [NSNumber numberWithInt:2],
          [NSNumber numberWithInt:3],
          [NSNumber numberWithInt:4], nil],
         [NSNumber numberWithInt:CharacterStatGroupEarthSkills],
         
         [NSArray arrayWithObjects:
          [NSNumber numberWithInt:5], [NSNumber numberWithInt:6],
          [NSNumber numberWithInt:3], [NSNumber numberWithInt:6], [NSNumber numberWithInt:7], [NSNumber numberWithInt:8],
          [NSNumber numberWithInt:5], [NSNumber numberWithInt:6], [NSNumber numberWithInt:7],
          [NSNumber numberWithInt:5], [NSNumber numberWithInt:6],
          [NSNumber numberWithInt:5], [NSNumber numberWithInt:6], [NSNumber numberWithInt:7], [NSNumber numberWithInt:8],
          [NSNumber numberWithInt:5], [NSNumber numberWithInt:6], [NSNumber numberWithInt:7], [NSNumber numberWithInt:8], nil],
         [NSNumber numberWithInt:CharacterStatGroupAbilities],
         nil];
    }
    return _statValues;
}

@synthesize savedLookupKey = _dataGroupKey;


- (CharacterStats *)characterWithAllStats {
    return [self copy];
}

// Makes a copy of the class with the key saved for future lookups
- (CharacterStats *)characterWithStatGroup:(t_CharacterStatGroup)group {
    CharacterStats *data = [self copy];
    data.savedLookupKey = group;
    return data;
}

+ (NSInteger)numberOfStatGroupsFrom:(CharacterStats *)character {
    if (character.savedLookupKey) {
        return 1;
    } else {
        return [character.statDescriptions count];
    }
}

+ (NSInteger)numberOfEntriesFrom:(CharacterStats *)character {
    return [CharacterStats numberOfEntriesFrom:character inStatGroup:character.savedLookupKey];
}

+ (NSInteger)numberOfEntriesFrom:(CharacterStats *)character inStatGroup:(t_CharacterStatGroup)group {
    return [[character.statValues objectForKey:[NSNumber numberWithInt:group]] count];
}

+ (NSString *)sectionHeadingFrom:(CharacterStats *)character {
    return [CharacterStats sectionHeadingFrom:character inStatGroup:character.savedLookupKey];
}

+ (NSString *)sectionHeadingFrom:(CharacterStats *)character inStatGroup:(t_CharacterStatGroup)group {
    return [character.statGroupHeadings objectForKey:[NSNumber numberWithInt:group]];
}

+ (NSString *)statDescriptionFrom:(CharacterStats *)character atIndex:(NSInteger)index {
    return [CharacterStats statDescriptionFrom:character atIndex:index inStatGroup:character.savedLookupKey];
}

+ (NSString *)statDescriptionFrom:(CharacterStats *)character atIndex:(NSInteger)index inStatGroup:(t_CharacterStatGroup)group {
    return [[character.statDescriptions objectForKey:[NSNumber numberWithInt:group]] objectAtIndex:index];
}
            
+ (NSNumber *)statValueFrom:(CharacterStats *)character atIndex:(NSInteger)index {
    return [CharacterStats statValueFrom:character atIndex:index inStatGroup:character.savedLookupKey];
}

+ (NSNumber *)statValueFrom:(CharacterStats *)character atIndex:(NSInteger)index inStatGroup:(t_CharacterStatGroup)group {
    return [[character.statValues objectForKey:[NSNumber numberWithInt:group]] objectAtIndex:index];
}

+ (t_CharacterStatElement)statElementFrom:(CharacterStats *)character atIndex:(NSInteger)index {
    return [CharacterStats statElementFrom:character atIndex:index inStatGroup:character.savedLookupKey];
}

+ (t_CharacterStatElement)statElementFrom:(CharacterStats *)character atIndex:(NSInteger)index inStatGroup:(t_CharacterStatGroup)group {
    return [[[character.statElements objectForKey:[NSNumber numberWithInt:group]] objectAtIndex:index] integerValue];
}

+ (NSNumber *)primaryStatForSkillGroupFrom:(CharacterStats *)character {
    return [CharacterStats primaryStatForSkillGroupFrom:character inStatGroup:character.savedLookupKey];
}

+ (NSNumber *)primaryStatForSkillGroupFrom:(CharacterStats *)character inStatGroup:(t_CharacterStatGroup)group {
    NSInteger index = 0;
    if (group == CharacterStatGroupFireSkills) index = 0;
    else if (group == CharacterStatGroupAirSkills) index = 1;
    else if (group == CharacterStatGroupWaterSkills) index = 2;
    else if (group == CharacterStatGroupEarthSkills) index = 3;
    else if (group == CharacterStatGroupChiSkills) index = 4;
    
    return [[character.statValues objectForKey:[NSNumber numberWithInt:CharacterStatGroupPrimary]] objectAtIndex:index];
}

+ (NSNumber *)soulStatFrom:(CharacterStats *)character forStat:(t_CharacterStatSoul)stat {
    NSInteger index = 0;
    if (stat == CharacterStatSoulBody) index = 0;
    else if (stat == CharacterStatSoulMind) index = 1;
    else if (stat == CharacterStatSoulSpirit) index = 2;
    
    return [[character.statValues objectForKey:[NSNumber numberWithInt:CharacterStatGroupSoul]] objectAtIndex:index];

}


+ (t_CharacterStatElement)statElementforHeadingFrom:(CharacterStats *)characterData {
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
	CharacterStats *copy = [[CharacterStats allocWithZone: zone] init];
    copy.statDescriptions = self.statDescriptions;
    copy.statValues = self.statValues;
    copy.statElements = self.statElements;
    return copy;
}

@end
