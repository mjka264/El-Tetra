//
//  CharacterDataModel.m
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterData.h"

@interface CharacterData ()
// These two dictionaries are each dictionaries of non-mutable arrays
// They are accessed using the t_characterDataStatGroup keys (in .h) and correspond to one another
@property (nonatomic, strong) NSDictionary *statDescriptions; // of arrays
@property (nonatomic, strong) NSDictionary *statValues;       // of arrays

// This is the same as the above, although it currently only has data under the element key
@property (nonatomic, strong) NSDictionary *statElements;     // of arrays

// When a Character Data is passed as an ID, this property allows it to work out what was searched for
@property (nonatomic) NSInteger savedLookupKey;


@end


@implementation CharacterData

@synthesize statDescriptions = _statDescriptions;
- (NSDictionary *)statDescriptions {
    if (!_statDescriptions) {
        _statDescriptions =
        [NSDictionary dictionaryWithObjectsAndKeys:
         [NSArray arrayWithObjects:@"Body", @"Mind", @"Spirit", nil],
         [NSNumber numberWithInt:CharacterDataStatGroupSoul],
         
         [NSArray arrayWithObjects:@"Ferocity", @"Accuracy", @"Agility", @"Resilience", @"Chi", nil],
         [NSNumber numberWithInt:CharacterDataStatGroupPrimary],
         
         [NSArray arrayWithObjects:
          @"Power, speed, lifting",
          @"Instinct, innovation, insight, synthesis",
          @"Passion, agression, assertion, intimidation", nil],
         [NSNumber numberWithInt:CharacterDataStatGroupFireSkills],
         
         [NSArray arrayWithObjects:
          @"Craft, lockpicking",
          @"Logic, science, reasoning, investigation, memory",
          @"Culture, disguise, trickery, cunning", nil],
         [NSNumber numberWithInt:CharacterDataStatGroupAirSkills],
         
         [NSArray arrayWithObjects:
          @"Balance, stealth, reflexes",
          @"Language, interpretation",
          @"Empathy, charm, misdirection", nil],
         [NSNumber numberWithInt:CharacterDataStatGroupWaterSkills],
         
         [NSArray arrayWithObjects:
          @"Fortitude, stamina, labour",
          @"Perception, observation, procedure, tracking",
          @"Confidence, bravery, diligence, patience", nil],
         [NSNumber numberWithInt:CharacterDataStatGroupEarthSkills],
         
         [NSArray arrayWithObjects:
          @"Rend", @"Spellsword",
          @"Artful weapons", @"Brutal weapons", @"Critical strikes", @"Projectile weapons",
          @"Initiative", @"Leap/float", @"Multiple attacks",
          @"Defensive pause", @"Strength within",
          @"Daoism", @"Shifting (body)", @"Shifting (mind, spirit)", @"Offworld contact",
          @"Primal fire", @"Primal air", @"Primal water", @"Primal earth", nil],
         [NSNumber numberWithInt:CharacterDataStatGroupAbilities],
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
          [NSNumber numberWithInt: CharacterDataElementFire], [NSNumber numberWithInt: CharacterDataElementFire],
          [NSNumber numberWithInt: CharacterDataElementAir], [NSNumber numberWithInt: CharacterDataElementAir], [NSNumber numberWithInt: CharacterDataElementAir], [NSNumber numberWithInt: CharacterDataElementAir],
          [NSNumber numberWithInt: CharacterDataElementWater], [NSNumber numberWithInt: CharacterDataElementWater], [NSNumber numberWithInt: CharacterDataElementWater],
          [NSNumber numberWithInt: CharacterDataElementEarth], [NSNumber numberWithInt: CharacterDataElementEarth],
          [NSNumber numberWithInt: CharacterDataElementChi], [NSNumber numberWithInt: CharacterDataElementChi], [NSNumber numberWithInt: CharacterDataElementChi], [NSNumber numberWithInt: CharacterDataElementChi],
          [NSNumber numberWithInt: CharacterDataElementFireChi], [NSNumber numberWithInt: CharacterDataElementAirChi], [NSNumber numberWithInt: CharacterDataElementWaterChi], [NSNumber numberWithInt: CharacterDataElementEarthChi],
          nil],
         [NSNumber numberWithInt:CharacterDataStatGroupAbilities],
         nil];
    }
    return _statElements;
}

@synthesize statValues = _statValues;
- (NSDictionary *)statValues {
    if (!_statValues) {
        [NSDictionary dictionaryWithObjectsAndKeys:
         [NSArray arrayWithObjects:
          [NSNumber numberWithInt:1],
          [NSNumber numberWithInt:3],
          [NSNumber numberWithInt:4], nil],
         [NSNumber numberWithInt:CharacterDataStatGroupSoul],
         
         [NSArray arrayWithObjects:
          [NSNumber numberWithInt:1],
          [NSNumber numberWithInt:3],
          [NSNumber numberWithInt:1],
          [NSNumber numberWithInt:3],
          [NSNumber numberWithInt:4], nil],
         [NSNumber numberWithInt:CharacterDataStatGroupPrimary],
         
         [NSArray arrayWithObjects:
          [NSNumber numberWithInt:1],
          [NSNumber numberWithInt:3],
          [NSNumber numberWithInt:4], nil],
         [NSNumber numberWithInt:CharacterDataStatGroupFireSkills],
         
         [NSArray arrayWithObjects:
          [NSNumber numberWithInt:1],
          [NSNumber numberWithInt:3],
          [NSNumber numberWithInt:4], nil],
         [NSNumber numberWithInt:CharacterDataStatGroupAirSkills],
         
         [NSArray arrayWithObjects:
          [NSNumber numberWithInt:1],
          [NSNumber numberWithInt:3],
          [NSNumber numberWithInt:4], nil],
         [NSNumber numberWithInt:CharacterDataStatGroupWaterSkills],
         
         [NSArray arrayWithObjects:
          [NSNumber numberWithInt:1],
          [NSNumber numberWithInt:3],
          [NSNumber numberWithInt:4], nil],
         [NSNumber numberWithInt:CharacterDataStatGroupEarthSkills],
         
         [NSArray arrayWithObjects:
          [NSNumber numberWithInt:1], [NSNumber numberWithInt:1],
          [NSNumber numberWithInt:3], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1],
          [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1],
          [NSNumber numberWithInt:1], [NSNumber numberWithInt:1],
          [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1],
          [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil],
         [NSNumber numberWithInt:CharacterDataStatGroupAbilities],
         nil];
    }
    return _statValues;
}


@synthesize savedLookupKey = _dataGroupKey;


- (CharacterData *)characterWithAllStats {
    return [self copy];
}

// Makes a copy of the class with the key saved for future lookups
- (CharacterData *)characterWithStatGroup:(t_characterDataStatGroup)group {
    CharacterData *data = [self copy];
    data.savedLookupKey = group;
    return data;
}

+ (NSInteger)numberOfStatGroupsFrom:(CharacterData *)character {
    if (character.savedLookupKey) {
        return 1;
    } else {
        return [character.statDescriptions count];
    }
}

+ (NSInteger)numberOfEntriesFrom:(CharacterData *)character {
    return [CharacterData numberOfEntriesFrom:character inStatGroup:character.savedLookupKey];
}

+ (NSInteger)numberOfEntriesFrom:(CharacterData *)character inStatGroup:(t_characterDataElement)group {
    return [[character.statValues objectForKey:[NSNumber numberWithInt:group]] count];
}

+ (NSString *)sectionHeadingFrom:(CharacterData *)character {
    return [CharacterData sectionHeadingFrom:character inStatGroup:character.savedLookupKey];
}

+ (NSString *)sectionHeadingFrom:(CharacterData *)character inStatGroup:(t_characterDataElement)group {
    return @"FireBlah";
}

+ (NSString *)statDescriptionFrom:(CharacterData *)character atIndex:(NSInteger)index {
    return [CharacterData statDescriptionFrom:character atIndex:index inStatGroup:character.savedLookupKey];
}

+ (NSString *)statDescriptionFrom:(CharacterData *)character atIndex:(NSInteger)index inStatGroup:(t_characterDataElement)group {
    return [[character.statDescriptions objectForKey:[NSNumber numberWithInt:group]] objectAtIndex:index];
}
            
+ (NSNumber *)statValueFrom:(CharacterData *)character atIndex:(NSInteger)index {
    return [CharacterData statValueFrom:character atIndex:index inStatGroup:character.savedLookupKey];
}

+ (NSNumber *)statValueFrom:(CharacterData *)character atIndex:(NSInteger)index inStatGroup:(t_characterDataElement)group {
    return [[character.statValues objectForKey:[NSNumber numberWithInt:group]] objectAtIndex:index];
}

+ (t_characterDataElement)statElementFrom:(CharacterData *)character atIndex:(NSInteger)index {
    return [CharacterData statElementFrom:character atIndex:index inStatGroup:character.savedLookupKey];
}

+ (t_characterDataElement)statElementFrom:(CharacterData *)character atIndex:(NSInteger)index inStatGroup:(t_characterDataElement)group {
    return [[[character.statElements objectForKey:[NSNumber numberWithInt:group]] objectAtIndex:index] integerValue];
}

+ (t_characterDataElement)statElementforHeadingFrom:(CharacterData *)characterData {
    switch (characterData.savedLookupKey) {
        case CharacterDataStatGroupFireSkills:
            return CharacterDataElementFire;
        case CharacterDataStatGroupAirSkills:
            return CharacterDataElementAir;
        case CharacterDataStatGroupWaterSkills:
            return CharacterDataElementWater;
        case CharacterDataStatGroupEarthSkills:
            return CharacterDataElementEarth;
        default:
            return CharacterDataElementChi;
    }
}

// This depends on the enum for t_characterDataStatGroup starting at 0 and being in order
+ (NSInteger)dataStatGroupForSectionNumber:(NSInteger)index {
    return index;
}

- (id)copyWithZone:(NSZone *)zone
{
	CharacterData *copy = [[CharacterData allocWithZone: zone] init];
    copy.statDescriptions = self.statDescriptions;
    copy.statValues = self.statValues;
    copy.statElements = self.statElements;
    return copy;
}

@end
