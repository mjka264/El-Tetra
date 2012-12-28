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

+ (NSArray *)allItems {
    if (!_allItems) {
        _allItems = [NSArray arrayWithObjects:
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
                     [Item initStandardWeaponWithName:@"Free hand"
                                                 type:ItemTypeWeaponOffhand
                                                style:ItemCombatStyleEitherMelee
                                     defensePermitted:ItemWeaponDefensePermittedNA
                                        defenseGained:ItemDefenseGainedNone
                                               damage:0 speed:5 miscellaneous:[NSArray array]],
                     [Item initStandardWeaponWithName:@"Polearm"
                                                 type:ItemTypeWeaponDualhand
                                                style:ItemCombatStyleBrutal
                                     defensePermitted:ItemWeaponDefensePermittedAny
                                        defenseGained:ItemDefenseGainedNone
                                               damage:10 speed:0 miscellaneous:[NSArray arrayWithObject:@"Reach"]],
                     [Item initStandardArmourWithName:@"Heavy armour"
                                                speed:-5
                                                 soak:3
                                        miscellaneous:[NSArray arrayWithObject:@"Body skills: -1"]],
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
