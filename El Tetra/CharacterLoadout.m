//
//  CharacterLoadout.m
//  El Tetra
//
//  Created by Matthew Kameron on 27/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterLoadout.h"

@interface CharacterLoadout ()
@property (nonatomic) t_characterLoadoutWeapons weapons;
@property (nonatomic) t_characterLoadoutArmour armour;
@property (nonatomic, strong) t_characterLoadoutGear gear;
@end

@implementation CharacterLoadout

@synthesize weapons = _weapons;
@synthesize armour = _armour;
@synthesize gear = _gear;
- (t_characterLoadoutGear)gear {
    if (!_gear) _gear = [[NSArray alloc] init];
    return _gear;
}

+ (CharacterLoadout *)loadoutEmpty {
    return [[CharacterLoadout alloc] init];
}

+ (CharacterLoadout *)loadoutWithWeapons:(t_characterLoadoutWeapons)weapons
                                  armour:(t_characterLoadoutArmour)armour
                                    gear:(t_characterLoadoutGear)gear {
    CharacterLoadout *loadout = [CharacterLoadout loadoutEmpty];
    loadout.weapons = weapons;
    loadout.armour = armour;
    loadout.gear = gear;
    return loadout;
}

- (NSString *)weaponDescriptorMainhand {
    if (self.weapons == 1) {
        return @"Swordy thing";
    } else {
        return @"Stab Stab";
    }
}

- (NSString *)weaponDescriptorOffhand {
    return @"Shieldy thing";
}

- (NSString *)armourDescriptor {
    return @"Armour thing";
}

- (NSArray *)gearDescriptors {
    return [NSArray arrayWithObjects:@"Rope", @"Stepladder", nil];
}

@end
