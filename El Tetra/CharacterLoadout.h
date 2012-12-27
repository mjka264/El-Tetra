//
//  CharacterLoadout.h
//  El Tetra
//
//  Created by Matthew Kameron on 27/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CharacterLoadoutWeaponsSword = 1,
    CharacterLoadoutWeaponsAxe = 2,
    CharacterLoadoutWeaponsDagger = 3
} t_characterLoadoutWeapons;

typedef enum {
    CharacterLoadoutArmourStandard = 1,
    CharacterLoadoutArmourHeavy = 2,
    CharacterLoadoutArmourMilitary = 3
} t_characterLoadoutArmour;

typedef NSArray* t_characterLoadoutGear;

@interface CharacterLoadout : NSObject
+ (CharacterLoadout *)loadoutEmpty;
+ (CharacterLoadout *)loadoutWithWeapons:(t_characterLoadoutWeapons)weapons
                                  armour:(t_characterLoadoutArmour)armour
                                    gear:(t_characterLoadoutGear)gear;
- (NSString *)weaponDescriptorMainhand;
- (NSString *)weaponDescriptorOffhand;
- (NSString *)armourDescriptor;
- (NSArray *)gearDescriptors;   // of the gear type, obviously!!
@end
