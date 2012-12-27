//
//  ElTerta.m
//  El Tetra
//
//  Created by Matthew Kameron on 24/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "ElTetraDummyDelegate.h"
#import "CharacterStats.h"
#import "StatTableViewController.h"

/*
@interface ElTetraDummyDelegate()
@property (nonatomic, strong) CharacterData *characterData;
@end

@implementation ElTetraDummyDelegate

// StatTableViewHeaderDataSource
- (NSString *)textForHeading: (UIView *)source {
    return @"Dummy Delegate";
}
- (NSNumber *)fontSizeForHeading: (UIView *)source {
    return [NSNumber numberWithInt:16];
}
- (NSNumber *)numberForCircle:(UIView *)source {
    return [NSNumber numberWithInt:16];
}
- (NSString *)elementForCircle:(UIView *)source {
    return @"Water";
}
- (NSNumber *)fontSizeForNumber:(UIView *)source {
    return [NSNumber numberWithInt:16];
}





// StatTableViewControllerDataSource
#define DTVC_SOUL @"SoulStatsViewController"
#define DTVC_PRIMARY @"PrimaryStatsViewController"
#define DTVC_FIRE_STATS @"FireSkillStatsViewController"
#define DTVC_AIR_STATS @"AirSkillStatsViewController"
#define DTVC_WATER_STATS @"WaterSkillStatsViewController"
#define DTVC_EARTH_STATS @"EarthSkillStatsViewController"
#define DTVC_FIRE_ABILITIES @"FireAbilityStatsViewController"
#define DTVC_AIR_ABILITIES @"AirAbilityStatsViewController"
#define DTVC_WATER_ABILITIES @"WaterAbilityStatsViewController"
#define DTVC_EARTH_ABILITIES @"EarthAbilityStatsViewController"

- (CharacterData *)characterData
{
    if (!_characterData) _characterData = [[CharacterData alloc] init];
    return _characterData;
}

- (NSString *)elementForDisplay:(UIViewController *)source
{
    return @"Air";
}

- (NSString *)primaryStatValueForDisplay:(UIViewController *)source
{
    return @"7";
}

- (NSString *)headingForDisplay:(UIViewController *)source
{
    return @"Resilience";
}

- (NSOrderedSet *)dataForDisplay:(UIViewController *)source
{
    NSDictionary *stats; // The actual stats pulled from the model
    NSOrderedSet *orderedStatList; // The order in which they should be presented, also from the model
    NSMutableOrderedSet *orderedStats = [[NSMutableOrderedSet alloc] init]; // what we are building
    
    stats = [self.characterData skillStats];
    orderedStatList = [CharacterData waterSkillsPresentationOrder];
     
    // Now build the orderStats list with the correct things.
    // Store this data in StatTableViewControllerData objects, as requested by StatTableViewController
    for (NSString *statName in orderedStatList) {
        if ([stats valueForKey:statName]) {
            [orderedStats addObject:[StatTableViewControllerData
                                     dataWithValue:[[stats valueForKey:statName] integerValue]
                                     forCharacteristic:statName]];
        }
    }
    
    // The return value is a set of sets. The outer set defines sections. For now, just the one section.
    NSOrderedSet *metaset = [NSOrderedSet orderedSetWithObject:orderedStats];
    return metaset;
}


@end
*/