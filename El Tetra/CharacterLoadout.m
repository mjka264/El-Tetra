//
//  CharacterLoadout.m
//  El Tetra
//
//  Created by Matthew Kameron on 27/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterLoadout.h"
#import "Item.h"

@interface CharacterLoadout ()
@property (nonatomic, strong) Item *mainhand;
@property (nonatomic, strong) Item *offhand;
@property (nonatomic, strong) Item *armour;
@property (nonatomic, strong) NSArray *gear;   // of Item
- (NSNumber *)deriveSumBySelector:(SEL)sel;
- (t_ItemDefenseGained)derivedSpecialDefenseType;
@end

@implementation CharacterLoadout

@synthesize name = _name;
@synthesize mainhand = _mainhand;
- (void)setMainhand:(Item *)mainhand {
    _mainhand = mainhand;
    if (_mainhand.itemType == ItemTypeWeaponDualhand) {
        self.offhand = nil;
    } else if (_mainhand.itemType == ItemTypeWeaponMainhand) {
        if (!self.offhand) {
            self.offhand = [Item defaultOffhand];
        }
    }
}
@synthesize offhand = _offhand;
- (void)setOffhand:(Item *)offhand {
    if (self.mainhand.itemType == ItemTypeWeaponMainhand) {
        _offhand = offhand;
    } else {
        _offhand = nil;
    }
}
@synthesize armour = _armour;
@synthesize gear = _gear;
- (NSArray *)gear {
    if (!_gear) _gear = [[NSArray alloc] init];
    return _gear;
}

+ (CharacterLoadout *)defaultLoadout {
    CharacterLoadout *loadout = [[CharacterLoadout alloc] init];
    loadout.name = @"Default";
    loadout.mainhand = [Item defaultMainhand];
    //loadout.offhand = [Item defaultOffhand];
    loadout.armour = [Item defaultArmour];
    return loadout;
}

@synthesize characterStats = _characterStats;

- (NSString *)mainhandName {
    return self.mainhand.name;
}

- (NSString *)offhandName {
    return self.offhand.name;
}

- (NSString *)armourName {
    return self.armour.name;
}

- (NSArray *)gearNames {
    NSMutableArray *newArray;
    [self.gear enumerateObjectsUsingBlock:^(Item *obj, NSUInteger idx, BOOL *stop) {
        [newArray addObject:obj.name];
    }];
    return newArray;
}

- (NSArray *)mainhandSpecials {
    return self.mainhand.miscellaneousProperties;
}

- (NSArray *)offhandSpecials {
    return self.offhand.miscellaneousProperties;
}

- (NSArray *)armourSpecials {
    return self.armour.miscellaneousProperties;
}

- (NSArray *)gearSpecials {
    NSMutableArray *newArray;
    [self.gear enumerateObjectsUsingBlock:^(Item *obj, NSUInteger idx, BOOL *stop) {
        [newArray addObjectsFromArray:obj.miscellaneousProperties];
    }];
    return newArray;
}

- (t_ItemWeaponDefensePermitted)weaponDefensePermitted {
    return self.mainhand.weaponDefensePermitted;
}




- (NSNumber *)deriveSumBySelector:(SEL)sel {
    __block NSInteger modifier = 0;
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    modifier += [[self.mainhand performSelector:sel] intValue];
    modifier += [[self.offhand performSelector:sel] intValue];
    modifier += [[self.armour performSelector:sel] intValue];
    [self.gear enumerateObjectsUsingBlock:^(Item *obj, NSUInteger idx, BOOL *stop) {
        modifier += [[obj performSelector:sel] intValue];
    }];
    #pragma clang diagnostic pop
    
    return [NSNumber numberWithInteger:modifier];
}


- (NSNumber *)derivedSpeed:(BOOL)dicePoolNotModifier {
    if (dicePoolNotModifier) return [self.characterStats effectiveStatInitiative];
    else return [self deriveSumBySelector:@selector(speedModifier)];
}

- (NSNumber *)derivedAttack:(BOOL)dicePoolNotModifier {
    if (dicePoolNotModifier) {
        NSNumber *attackDice;
        if (self.mainhand.weaponCombatStyle == ItemCombatStyleArtful) {
            attackDice = [self.characterStats effectiveStatAttackArtful];
        } else if (self.mainhand.weaponCombatStyle == ItemCombatStyleBrutal) {
            attackDice = [self.characterStats effectiveStatAttackArtful];
        } else if (self.mainhand.weaponCombatStyle == ItemCombatStyleEitherMelee) {
            attackDice = MAX([self.characterStats effectiveStatAttackArtful],
                             [self.characterStats effectiveStatAttackBrutal]);
        } else if (self.mainhand.weaponCombatStyle == ItemCombatStyleRanged) {
            attackDice = [self.characterStats effectiveStatAttackProjectile];
        } else if (self.mainhand.weaponCombatStyle == ItemCombatStyleNoTrainingRequired) {
            attackDice = [self.characterStats effectiveStatRawPrecision];
        }
        return attackDice;
    } else {
        return [self deriveSumBySelector:@selector(attackModifier)];
    }
}

- (NSNumber *)derivedDamage:(BOOL)dicePoolNotModifier {
    if (dicePoolNotModifier) return [self.characterStats effectiveStatDamage];
    else return [self deriveSumBySelector:@selector(damageModifier)];
}

// BUG this should really live in CharacterStats
+ (NSNumber *)calculateDefenseValueBasedOnStatValue:(NSNumber *)statValue {
    return [NSNumber numberWithInt:13 + 2 * [statValue integerValue]];
}

- (NSNumber *)derivedBasicDefense {
    return [[self class] calculateDefenseValueBasedOnStatValue:[self.characterStats effectiveStatDodge]];
}

- (t_ItemDefenseGained)derivedSpecialDefenseType {
    BOOL parryOffered = FALSE;
    BOOL blockOffered = FALSE;
    if (self.mainhand.defenseGained == ItemDefenseGainedParry ||
        self.mainhand.defenseGained == ItemDefenseGainedBoth) parryOffered = TRUE;
    if (self.mainhand.defenseGained == ItemDefenseGainedBlock ||
        self.mainhand.defenseGained == ItemDefenseGainedBoth) blockOffered = TRUE;
    if (self.offhand.defenseGained == ItemDefenseGainedParry ||
        self.offhand.defenseGained == ItemDefenseGainedBoth) parryOffered = TRUE;
    if (self.offhand.defenseGained == ItemDefenseGainedBlock ||
        self.offhand.defenseGained == ItemDefenseGainedBoth) blockOffered = TRUE;
    
    if (parryOffered && blockOffered) return ItemDefenseGainedBoth;
    else if (parryOffered) return ItemDefenseGainedParry;
    else if (blockOffered) return ItemDefenseGainedBlock;
    else return ItemDefenseGainedNone;
}

- (NSNumber *)derivedMagicDefense {
    return [[self class] calculateDefenseValueBasedOnStatValue:[self.characterStats effectiveStatMagicDefense]];
}

- (NSNumber *)derivedParryDefense {
    if ([self derivedSpecialDefenseType] == ItemDefenseGainedParry) {
        return [NSNumber numberWithInteger:[[self derivedBasicDefense] integerValue] + 5];
    } else if ([self derivedSpecialDefenseType] == ItemDefenseGainedBoth) {
        return [NSNumber numberWithInteger:[[self derivedBasicDefense] integerValue] + 10];
    } else {
        return nil;
    }
}

- (NSNumber *)derivedBlockDefense {
    if ([self derivedSpecialDefenseType] == ItemDefenseGainedBlock ||
        [self derivedSpecialDefenseType] == ItemDefenseGainedBoth) {
        return [NSNumber numberWithInteger:[[self derivedBasicDefense] integerValue] + 5];
    } else {
        return nil;
    }
}

- (NSNumber *)derivedSoak {
    NSInteger soak = [[[self class] calculateDefenseValueBasedOnStatValue:[self.characterStats effectiveStatSoak]] integerValue];
    soak += [[self deriveSumBySelector:@selector(soakModifier)] integerValue];
    return [NSNumber numberWithInteger:soak];
}

- (NSArray *)allItems {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if (self.mainhand) [array addObject:self.mainhand];
    if (self.offhand) [array addObject:self.offhand];
    if (self.armour) [array addObject:self.armour];
    if (self.gear) [array addObjectsFromArray:self.gear];
    return array;
}

- (BOOL)isEquippingItem:(Item *)item {
    __block BOOL matchFound = FALSE;
    [[self allItems] enumerateObjectsUsingBlock:^(Item *obj, NSUInteger idx, BOOL *stop) {
        if (obj == item) {
            matchFound = TRUE;
            *stop = TRUE;
        }
    }];
    return matchFound;
}

- (void)equipItem:(Item *)item {
    if (item.itemType == ItemTypeWeaponDualhand ||
        item.itemType == ItemTypeWeaponMainhand) {
        self.mainhand = item;
    } else if (item.itemType == ItemTypeWeaponOffhand) {
        self.offhand = item;
    } else if (item.itemType == ItemTypeArmour) {
        self.armour = item;
    } else if (item.itemType == ItemTypeGear) {
        [NSException raise:@"Not yet implemented" format:@"Not year implemented"];
    }
}

- (CharacterLoadout *)copyWithZone:(NSZone *)zone {
    CharacterLoadout *new = [CharacterLoadout defaultLoadout];
    new.mainhand = self.mainhand;
    new.offhand = self.offhand;
    new.armour = self.armour;
    new.gear = [self.gear copy];
    new.name = [self.name stringByAppendingString:@" copy"];
    return new;
}

@end
