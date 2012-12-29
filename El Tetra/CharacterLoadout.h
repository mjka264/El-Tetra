//
//  CharacterLoadout.h
//  El Tetra
//
//  Created by Matthew Kameron on 27/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@protocol CharacterLoadoutAssistsDerivation <NSObject>
- (NSNumber *)effectiveStatInitiative;
- (NSNumber *)effectiveStatAttackArtful;
- (NSNumber *)effectiveStatAttackBrutal;
- (NSNumber *)effectiveStatAttackProjectile;
- (NSNumber *)effectiveStatDamage;
- (NSNumber *)effectiveStatDodge;
- (NSNumber *)effectiveStatSoak;
- (NSNumber *)effectiveStatMagicDefense;
- (NSNumber *)effectiveStatRawPrecision;
@end

@interface CharacterLoadout : NSObject <NSCopying>
+ (CharacterLoadout *)defaultLoadout;

+ (NSNumber *)calculateDefenseValueBasedOnStatValue:(NSNumber *)statValue;

// This has to be set to link the character loadout with a character stats
// Once this is done, each of the derived calculations will work correctly
@property (nonatomic, weak) id<CharacterLoadoutAssistsDerivation>characterStats;
@property (nonatomic, strong) NSString *name;  // The name of the loadout for display in the title bar

- (NSString *)mainhandName;
- (NSString *)offhandName;
- (NSString *)armourName;
- (NSArray *)gearNames;        // of NSString

- (NSArray *)mainhandSpecials; // of NSString
- (NSArray *)offhandSpecials;  // of NSString
- (NSArray *)armourSpecials;   // of NSString
- (NSArray *)gearSpecials;     // of NSString

- (t_ItemWeaponDefensePermitted)weaponDefensePermitted;

// These return either the dice pool or the modifier depending on the parameter
- (NSNumber *)derivedSpeed:(BOOL)dicePoolNotModifier;
- (NSNumber *)derivedAttack:(BOOL)dicePoolNotModifier;
- (NSNumber *)derivedDamage:(BOOL)dicePoolNotModifier;
- (NSNumber *)derivedParryDefense; // nil if no parry
- (NSNumber *)derivedBlockDefense; // nil if no block
- (NSNumber *)derivedBasicDefense;
- (NSNumber *)derivedMagicDefense;
- (NSNumber *)derivedSoak;

- (NSArray *)allItems;
- (BOOL)isEquippingItem:(Item *)item;
- (void)equipItem:(Item *)item;

@end
