//
//  CharacterItem.m
//  El Tetra
//
//  Created by Matthew Kameron on 27/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "Item.h"

static NSArray *_allItems;

@implementation Item

@synthesize name = _name;
@synthesize itemType = _itemType;
@synthesize weaponCombatStyle = _weaponCombatStyle;
@synthesize weaponDefensePermitted = _weaponDefensePermitted;
@synthesize defenseGained = _defenseGained;
@synthesize attackModifier = _attackModifier;
@synthesize damageModifier = _damageModifier;
@synthesize speedModifier = _speedModifier;
@synthesize soakModifier = _soakModifier;
@synthesize bodyModifier = _bodyModifier;
@synthesize miscellaneousProperties = _miscellaneousProperties;
- (NSArray *)miscellaneousProperties {
    if (!_miscellaneousProperties) _miscellaneousProperties = [NSArray array];
    return _miscellaneousProperties;
}

+ (Item *)itemWithName:(NSString *)name {
    __block Item *returnValue;
    [[Item allItems] enumerateObjectsUsingBlock:^(Item *obj, NSUInteger idx, BOOL *stop) {
        if ([name isEqualToString:obj.name]) {
            returnValue = obj;
            *stop = YES;
        }
    }];
    return returnValue;
}

+ (Item *)defaultMainhand {
    return [Item itemWithName:@"Quarterstaff"];
}
+ (Item *)defaultOffhand {
    return [Item itemWithName:@"Free hand"];
}
+ (Item *)defaultArmour {
    return [Item itemWithName:@"Leather armour"];
}

+ (NSArray *)allItems {
    if (!_allItems) {
        _allItems = [NSArray arrayWithObjects:
                     [Item initStandardWeaponWithName:@"Quarterstaff"
                                                 type:ItemTypeWeaponDualhand
                                                style:ItemCombatStyleNoTrainingRequired
                                     defensePermitted:ItemWeaponDefensePermittedAny
                                        defenseGained:ItemDefenseGainedParry
                                               damage:0 speed:0 miscellaneous:[NSArray array]],
                     [Item initStandardWeaponWithName:@"Greataxe"
                                                 type:ItemTypeWeaponDualhand
                                                style:ItemCombatStyleBrutal
                                     defensePermitted:ItemWeaponDefensePermittedBasic
                                        defenseGained:ItemDefenseGainedNone
                                               damage:10 speed:0 miscellaneous:[NSArray array]],
                     [Item initStandardWeaponWithName:@"Bastard Sword"
                                                 type:ItemTypeWeaponDualhand
                                                style:ItemCombatStyleArtful
                                     defensePermitted:ItemWeaponDefensePermittedAny
                                        defenseGained:ItemDefenseGainedNone
                                               damage:10 speed:5 miscellaneous:[NSArray array]],
                     [Item initStandardWeaponWithName:@"Polearm"
                                                 type:ItemTypeWeaponDualhand
                                                style:ItemCombatStyleBrutal
                                     defensePermitted:ItemWeaponDefensePermittedAny
                                        defenseGained:ItemDefenseGainedNone
                                               damage:10 speed:0 miscellaneous:[NSArray arrayWithObject:@"Reach"]],
                     
                     [Item initStandardWeaponWithName:@"Longsword"
                                                 type:ItemTypeWeaponMainhand
                                                style:ItemCombatStyleEitherMelee
                                     defensePermitted:ItemWeaponDefensePermittedAny
                                        defenseGained:ItemDefenseGainedNone
                                               damage:10 speed:0 miscellaneous:[NSArray array]],
                     [Item initStandardWeaponWithName:@"Shortsword"
                                                 type:ItemTypeWeaponMainhand
                                                style:ItemCombatStyleArtful
                                     defensePermitted:ItemWeaponDefensePermittedAny
                                        defenseGained:ItemDefenseGainedParry
                                               damage:5 speed:5 miscellaneous:[NSArray array]],
                     [Item initStandardWeaponWithName:@"Dagger"
                                                 type:ItemTypeWeaponMainhand
                                                style:ItemCombatStyleArtful
                                     defensePermitted:ItemWeaponDefensePermittedAny
                                        defenseGained:ItemDefenseGainedNone
                                               damage:5 speed:10 miscellaneous:[NSArray array]],
                     [Item initStandardWeaponWithName:@"Mace"
                                                 type:ItemTypeWeaponMainhand
                                                style:ItemCombatStyleBrutal
                                     defensePermitted:ItemWeaponDefensePermittedBasic
                                        defenseGained:ItemDefenseGainedNone
                                               damage:5 speed:5 miscellaneous:[NSArray array]],
                     
                     [Item initStandardWeaponWithName:@"Free hand"
                                                 type:ItemTypeWeaponOffhand
                                                style:ItemCombatStyleEitherMelee
                                     defensePermitted:ItemWeaponDefensePermittedNA
                                        defenseGained:ItemDefenseGainedNone
                                               damage:0 speed:5 miscellaneous:[NSArray array]],
                     [Item initStandardWeaponWithName:@"Wakizashi"
                                                 type:ItemTypeWeaponOffhand
                                                style:ItemCombatStyleArtful
                                     defensePermitted:ItemWeaponDefensePermittedNA
                                        defenseGained:ItemDefenseGainedParry
                                               damage:0 speed:0 miscellaneous:[NSArray array]],
                     [Item initStandardWeaponWithName:@"Shield"
                                                 type:ItemTypeWeaponOffhand
                                                style:ItemCombatStyleEitherMelee
                                     defensePermitted:ItemWeaponDefensePermittedNA
                                        defenseGained:ItemDefenseGainedBlock
                                               damage:0 speed:-5 miscellaneous:[NSArray array]],
                     
                     [Item initStandardWeaponWithName:@"Bow"
                                                 type:ItemTypeWeaponDualhand
                                                style:ItemCombatStyleRanged
                                     defensePermitted:ItemWeaponDefensePermittedBasicOrBlock
                                        defenseGained:ItemDefenseGainedNone
                                               damage:5 speed:5 miscellaneous:[NSArray array]],
                     [Item initStandardWeaponWithName:@"Crossbow"
                                                 type:ItemTypeWeaponDualhand
                                                style:ItemCombatStyleRanged
                                     defensePermitted:ItemWeaponDefensePermittedBasicOrBlock
                                        defenseGained:ItemDefenseGainedNone
                                               damage:10 speed:-5 miscellaneous:[NSArray array]],
                     
                     [Item initStandardArmourWithName:@"No armour"
                                                speed:0
                                                 soak:-3
                                        miscellaneous:[NSArray array]],
                     [Item initStandardArmourWithName:@"Leather armour"
                                                speed:0
                                                 soak:0
                                        miscellaneous:[NSArray array]],
                     [Item initStandardArmourWithName:@"Chainmail"
                                                speed:-5
                                                 soak:3
                                        miscellaneous:[NSArray arrayWithObject:@"Body skills: -1"]],
                     [Item initStandardArmourWithName:@"Plate"
                                                speed:-10
                                                 soak:6
                                        miscellaneous:[NSArray arrayWithObjects:@"Body skills: -2", @"Max one action per turn", nil]],
                     nil];
    }
    return _allItems;
}

+ (NSArray *)allItemsWithType:(t_ItemType)type {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [[self allItems] enumerateObjectsUsingBlock:^(Item *obj, NSUInteger idx, BOOL *stop) {
        if (obj.itemType == type) {
            [array addObject:obj];
        }
    }];
    return array;
}

+ (Item *)initStandardWeaponWithName:(NSString *)name
                                type:(t_ItemType)type
                               style:(t_ItemCombatStyle)style
                    defensePermitted:(t_ItemWeaponDefensePermitted)defenses
                       defenseGained:(t_ItemDefenseGained)newDefenses
                              damage:(NSInteger)damage
                               speed:(NSInteger)speed
                       miscellaneous:(NSArray *)properties {
    return [Item initItemWithName:name type:type style:style defensePermitted:defenses defenseGained:newDefenses attack:0 damage:damage speed:speed soak:0 miscellaneous:properties];
}

+ (Item *)initStandardArmourWithName:(NSString *)name
                               speed:(NSInteger)speed
                                soak:(NSInteger)soak
                       miscellaneous:(NSArray *)properties {
    return [Item initItemWithName:name type:ItemTypeArmour style:ItemCombatStyleNA defensePermitted:ItemWeaponDefensePermittedNA defenseGained:ItemDefenseGainedNone attack:0 damage:0 speed:speed soak:soak miscellaneous:properties];
}

+ (Item *)initItemWithName:(NSString *)name
                      type:(t_ItemType)type
                     style:(t_ItemCombatStyle)style
          defensePermitted:(t_ItemWeaponDefensePermitted)defenses
             defenseGained:(t_ItemDefenseGained)newDefenses
                    attack:(NSInteger)attack
                    damage:(NSInteger)damage
                     speed:(NSInteger)speed
                      soak:(NSInteger)soak
             miscellaneous:(NSArray *)properties {
    Item *item = [[Item alloc] init];
    item.name = name;
    item.itemType = type;
    item.weaponCombatStyle = style;
    item.weaponDefensePermitted = defenses;
    item.defenseGained = newDefenses;
    item.attackModifier = [NSNumber numberWithInt:attack];
    item.damageModifier = [NSNumber numberWithInt:damage];
    item.speedModifier = [NSNumber numberWithInt:speed];
    item.soakModifier = [NSNumber numberWithInt:soak];
    item.miscellaneousProperties = properties;
    return item;
}

+ (NSArray *)itemCategories {
    return [NSArray arrayWithObjects:
            [NSNumber numberWithInteger:ItemTypeWeaponDualhand],
             [NSNumber numberWithInteger:ItemTypeWeaponMainhand],
             [NSNumber numberWithInteger:ItemTypeWeaponOffhand],
             [NSNumber numberWithInteger:ItemTypeArmour],
             [NSNumber numberWithInteger:ItemTypeGear],
            nil];
}

NSString *explicitSign(NSNumber *num) {
    NSInteger x = [num integerValue];
    if (x > 0) {
        return [NSString stringWithFormat:@"+%d", x];
    } else {
        return [NSString stringWithFormat:@"%d", x];
    }
}

- (NSString *)itemPropertiesSummaryForTableView {
    //NSMutableString *s = [[NSMutableString alloc] init];
    NSMutableArray *properties = [[NSMutableArray alloc] init];
    if (self.weaponCombatStyle == ItemCombatStyleArtful) [properties addObject:@"Artful"];
    if (self.weaponCombatStyle == ItemCombatStyleBrutal) [properties addObject:@"Brutal"];
    if (self.weaponCombatStyle == ItemCombatStyleRanged) [properties addObject:@"Ranged"];
    if (self.weaponCombatStyle == ItemCombatStyleNoTrainingRequired) [properties addObject:@"No training required"];
    if (self.weaponDefensePermitted == ItemWeaponDefensePermittedBasic) [properties addObject:@"basic defense only"];
    if (self.weaponDefensePermitted == ItemWeaponDefensePermittedBasicOrBlock) [properties addObject:@"cannot be parried"];
    if (self.weaponDefensePermitted == ItemWeaponDefensePermittedBasicOrParry) [properties addObject:@"cannot be blocked"];
    if (self.defenseGained == ItemDefenseGainedBlock || self.defenseGained == ItemDefenseGainedBlock) [properties addObject:@"Block"];
    if (self.defenseGained == ItemDefenseGainedParry || self.defenseGained == ItemDefenseGainedBlock) [properties addObject:@"Parry"];
    if ([self.speedModifier integerValue] != 0) [properties addObject:[NSString stringWithFormat:@"Speed: %@", explicitSign(self.speedModifier)]];
    if ([self.attackModifier integerValue] != 0) [properties addObject:[NSString stringWithFormat:@"Attack: %@", explicitSign(self.attackModifier)]];
    if ([self.damageModifier integerValue] != 0) [properties addObject:[NSString stringWithFormat:@"Damage: %@", explicitSign(self.damageModifier)]];
    if ([self.soakModifier integerValue] != 0) [properties addObject:[NSString stringWithFormat:@"Soak: %@", explicitSign(self.soakModifier)]];
    if ([self.miscellaneousProperties count]) [properties addObject:[self.miscellaneousProperties componentsJoinedByString:@", "]];
    return [properties componentsJoinedByString:@", "];
}

@end
