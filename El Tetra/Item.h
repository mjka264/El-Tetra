//
//  CharacterItem.h
//  El Tetra
//
//  Created by Matthew Kameron on 27/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <Foundation/Foundation.h>

// If I add a new type, I need to change the class method itemCategories too 
typedef enum {
    ItemTypeWeaponDualhand = 1,
    ItemTypeWeaponMainhand = 2,
    ItemTypeWeaponOffhand = 3,
    ItemTypeArmour = 4,
    ItemTypeGear = 5
} t_ItemType;
// See comment above

typedef enum {
    ItemCombatStyleArtful = 1,
    ItemCombatStyleBrutal = 2,
    ItemCombatStyleRanged = 3,
    ItemCombatStyleEitherMelee = 4,
    ItemCombatStyleNA = 5
} t_ItemCombatStyle;

typedef enum {
    ItemWeaponDefensePermittedBasic = 1,
    ItemWeaponDefensePermittedBasicOrBlock = 2,
    ItemWeaponDefensePermittedBasicOrParry = 3,
    ItemWeaponDefensePermittedAny = 4,
    ItemWeaponDefensePermittedNA = 5
} t_ItemWeaponDefensePermitted;

typedef enum {
    ItemDefenseGainedNone = 1,
    ItemDefenseGainedParry = 2,
    ItemDefenseGainedBlock = 3,
    ItemDefenseGainedBoth = 4
} t_ItemDefenseGained;

@interface Item : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic) t_ItemType itemType;
@property (nonatomic) t_ItemCombatStyle weaponCombatStyle;
@property (nonatomic) t_ItemWeaponDefensePermitted weaponDefensePermitted;
@property (nonatomic) t_ItemDefenseGained defenseGained;
@property (nonatomic, strong) NSNumber *attackModifier;
@property (nonatomic, strong) NSNumber *damageModifier;
@property (nonatomic, strong) NSNumber *speedModifier;
@property (nonatomic, strong) NSNumber *soakModifier;
@property (nonatomic, strong) NSNumber *bodyModifier;
@property (nonatomic, strong) NSArray *miscellaneousProperties;  // of NSStrings

+ (NSArray *)itemCategories;
+ (NSArray *)allItems;
+ (NSArray *)allItemsWithType:(t_ItemType)type;
+ (Item *)initStandardWeaponWithName:(NSString *)name
                                type:(t_ItemType)type
                               style:(t_ItemCombatStyle)style
                    defensePermitted:(t_ItemWeaponDefensePermitted)defenses
                       defenseGained:(t_ItemDefenseGained)newDefenses
                              damage:(NSInteger)damage
                               speed:(NSInteger)speed
                       miscellaneous:(NSArray *)properties;
+ (Item *)initStandardArmourWithName:(NSString *)name
                               speed:(NSInteger)speed
                                soak:(NSInteger)soak
                       miscellaneous:(NSArray *)properties;
+ (Item *)initItemWithName:(NSString *)name
                      type:(t_ItemType)type
                     style:(t_ItemCombatStyle)style
          defensePermitted:(t_ItemWeaponDefensePermitted)defenses
             defenseGained:(t_ItemDefenseGained)newDefenses
                    attack:(NSInteger)attack
                    damage:(NSInteger)damage
                     speed:(NSInteger)speed
                      soak:(NSInteger)soak
             miscellaneous:(NSArray *)properties;
- (NSString *)itemPropertiesSummaryForTableView; // Does not include name

@end
