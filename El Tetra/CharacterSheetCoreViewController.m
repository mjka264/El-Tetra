//
//  CharacterSheetCoreViewController.m
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterSheetCoreViewController.h"
#import "CharacterData.h"

@interface CharacterSheetCoreViewController ()
@property (nonatomic, strong) CharacterData *characterData;
@end

#define DTVC_SOUL @"SoulStatsViewController"
#define DTVC_PRIMARY @"PrimaryStatsViewController"
#define DTVC_FIRE_STATS @"FireSkillStatsViewController"
#define DTVC_AIR_STATS @"AirSkillStatsViewController"
#define DTVC_WATER_STATS @"WaterSkillStatsViewController"
#define DTVC_EARTH_STATS @"EarthSkillStatsViewController"

@implementation CharacterSheetCoreViewController
@synthesize characterData = _characterData;
- (CharacterData *)characterData
{
    if (!_characterData) _characterData = [[CharacterData alloc] init];
    return _characterData;
}

- (NSString *)elementForDisplay:(StatTableViewController *)source
{
    NSString *response;
    if ([source.title isEqualToString:DTVC_FIRE_STATS]) {
        response = @"Fire";
    } else if ([source.title isEqualToString:DTVC_AIR_STATS]) {
        response = @"Air";
    } else if ([source.title isEqualToString:DTVC_WATER_STATS]) {
        response = @"Water";
    } else if ([source.title isEqualToString:DTVC_EARTH_STATS]) {
        response = @"Earth";
    }
    return response;
}

- (NSString *)headingForDisplay:(StatTableViewController *)source
{
    NSString *response;
    if ([source.title isEqualToString:DTVC_SOUL]) {
        response = @"Soul";
    } else if ([source.title isEqualToString:DTVC_PRIMARY]) {
        response = @"Primary Stats";
    } else if ([source.title isEqualToString:DTVC_FIRE_STATS]) {
        response = @"Ferocity";
    } else if ([source.title isEqualToString:DTVC_AIR_STATS]) {
        response = @"Precision";
    } else if ([source.title isEqualToString:DTVC_WATER_STATS]) {
        response = @"Agility";
    } else if ([source.title isEqualToString:DTVC_EARTH_STATS]) {
        response = @"Resilience";
    }
    return response;
}

- (NSOrderedSet *)dataForDisplay:(StatTableViewController *)source
{
    NSDictionary *stats; // The actual stats pulled from the model
    NSOrderedSet *orderedStatList; // The order in which they should be presented, also from the model
    NSMutableOrderedSet *orderedStats = [[NSMutableOrderedSet alloc] init]; // what we are building
    
    // These ifs load the correct data from the model
    if ([source.title isEqualToString:DTVC_SOUL]) {
        stats = [self.characterData soulStats];
        orderedStatList = [CharacterData soulStatsPresentationOrder];
    } else if ([source.title isEqualToString:DTVC_PRIMARY]) {
        stats = [self.characterData primaryStats];
        orderedStatList = [CharacterData primaryStatsPresentationOrder];
    } else if ([source.title isEqualToString:DTVC_FIRE_STATS]) {
        stats = [self.characterData skillStats];
        orderedStatList = [CharacterData fireSkillsPresentationOrder];
    } else if ([source.title isEqualToString:DTVC_AIR_STATS]) {
        stats = [self.characterData skillStats];
        orderedStatList = [CharacterData airSkillsPresentationOrder];
    } else if ([source.title isEqualToString:DTVC_WATER_STATS]) {
        stats = [self.characterData skillStats];
        orderedStatList = [CharacterData waterSkillsPresentationOrder];
    } else if ([source.title isEqualToString:DTVC_EARTH_STATS]) {
        stats = [self.characterData skillStats];
        orderedStatList = [CharacterData earthSkillsPresentationOrder];
    }

    // Now build the orderStats list with the correct things.
    // Store this data in StatTableViewControllerData objects, as requested by StatTableViewController
    for (NSString *statName in orderedStatList) {
        [orderedStats addObject:[StatTableViewControllerData
                                  dataWithValue:[[stats valueForKey:statName] integerValue]
                                  forCharacteristic:statName]];
    }
    
    // The return value is a set of sets. The outer set defines sections. For now, just the one section.
    NSOrderedSet *metaset = [NSOrderedSet orderedSetWithObject:orderedStats];
    return metaset;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[StatTableViewController class]]) {
        StatTableViewController *destination = segue.destinationViewController;
        destination.dataSource = self;
    }
}

@end
