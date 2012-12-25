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

#define CHARACTER_ABILITY_INITIATIVE @"Initiative"
#define CHARACTER_ABILITY_ARTFULWEAPONS @"Artful weapons"
#define CHARACTER_ABILITY_BRUTALWEAPONS @"Brutal weapons"
#define CHARACTER_ABILITY_PROJECTILEWEAPONS @"Projectile weapons"
#define CHARACTER_ABILITY_CRITICALSTRIKES @"Critical strikes"
#define CHARACTER_ABILITY_REND @"Rend"
#define CHARACTER_ABILITY_DEFENSIVEPAUSE @"Defensive pause"
#define CHARACTER_ABILITY_STRENGTHWITHIN @"Strength within"
#define CHARACTER_ABILITY_MULTIPLEATTACKS @"Multiple attacks"
#define CHARACTER_ABILITY_LEAPFLOAT @"Leap/float"
#define CHARACTER_ABILITY_SPELLSWORD @"Spellsword"
#define CHARACTER_ABILITY_DAOISM @"Daoism"
#define CHARACTER_ABILITY_OFFWORLDCONTACT @"Offworld contact"
#define CHARACTER_ABILITY_PRIMALFIRE @"Primal fire"
#define CHARACTER_ABILITY_PRIMALAIR @"Primal air"
#define CHARACTER_ABILITY_PRIMALWATER @"Primal water"
#define CHARACTER_ABILITY_PRIMALEARTH @"Primal earth"
#define CHARACTER_ABILITY_SHIFTINGBODY @"Shifting (body)"
#define CHARACTER_ABILITY_SHIFTINGMINDSPIRIT @"Shifting (mind, spirit)"

typedef const char * t_characterData;

@interface CharacterData : NSObject
- (id)dataWithAllStats;
- (id)dataWithStatsInGroup:(t_characterData)group;
@end
