//
//  CharacterDataModel.h
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CHARACTER_SOUL_BODY @"Body"
#define CHARACTER_SOUL_MIND @"Mind"
#define CHARACTER_SOUL_SPIRIT @"Spirit"

#define CHARACTER_PRIMARY_FEROCITY @"Ferocity"
#define CHARACTER_PRIMARY_ACCURACY @"Accuracy"
#define CHARACTER_PRIMARY_AGILITY @"Agility"
#define CHARACTER_PRIMARY_RESILIENCE @"Resilience"
#define CHARACTER_PRIMARY_CHI @"Chi"

#define CHARACTER_SKILL_FIRE_BODY @"Power, speed, lifting"
#define CHARACTER_SKILL_FIRE_MIND @"Instinct, innovation, insight, synthesis"
#define CHARACTER_SKILL_FIRE_SPIRIT @"Passion, agression, assertion, intimidation"
#define CHARACTER_SKILL_AIR_BODY @"Craft, lockpicking"
#define CHARACTER_SKILL_AIR_MIND @"Logic, science, reasoning, investigation, memory"
#define CHARACTER_SKILL_AIR_SPIRIT @"Culture, disguise, trickery, cunning"
#define CHARACTER_SKILL_WATER_BODY @"Balance, stealth, reflexes"
#define CHARACTER_SKILL_WATER_MIND @"Language, interpretation"
#define CHARACTER_SKILL_WATER_SPIRIT @"Empathy, charm, misdirection"
#define CHARACTER_SKILL_EARTH_BODY @"Fortitude, stamina, labour"
#define CHARACTER_SKILL_EARTH_MIND @"Perception, observation, procedure, tracking"
#define CHARACTER_SKILL_EARTH_SPIRIT @"Confidence, bravery, diligence, patience"

@interface CharacterData : NSObject
@property (nonatomic, strong) NSDictionary *soulStats;
@property (nonatomic, strong) NSDictionary *primaryStats;
@property (nonatomic, strong) NSDictionary *abilityStats;
@property (nonatomic, readonly, strong) NSDictionary *skillStats;
+ (NSOrderedSet *)soulStatsPresentationOrder;
+ (NSOrderedSet *)primaryStatsPresentationOrder;
+ (NSOrderedSet *)fireSkillsPresentationOrder;
+ (NSOrderedSet *)airSkillsPresentationOrder;
+ (NSOrderedSet *)waterSkillsPresentationOrder;
+ (NSOrderedSet *)earthSkillsPresentationOrder;

@end
