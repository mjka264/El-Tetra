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
@property (nonatomic, strong) NSMutableSet *statTableViewControllers;
- (void)logRequestFromStatTableViewController:(StatTableViewController *)controller;
@end

#define DTVC_SOUL @"SoulStatsController"
#define DTVC_PRIMARY @"PrimaryStatsController"
#define DTVC_FIRE_STATS @"FireStatsController"
#define DTVC_AIR_STATS @"AirStatsController"
#define DTVC_WATER_STATS @"WaterStatsController"
#define DTVC_EARTH_STATS @"EarthStatsController"
#define DTVC_CHI_STATS @"ChiStatsController"

@implementation CharacterSheetCoreViewController
@synthesize statTableViewControllers = _statTableViewControllers;
- (NSMutableSet *)statTableViewControllers {
    if (!_statTableViewControllers) {
        _statTableViewControllers = [[NSMutableSet alloc] init];
    }
    return _statTableViewControllers;
}

@synthesize characterData = _characterData;
- (CharacterData *)characterData
{
    if (!_characterData) _characterData = [[CharacterData alloc] init];
    return _characterData;
}

- (NSString *)elementForDisplay:(StatTableViewController *)source
{
    [self logRequestFromStatTableViewController:source];
    
    NSString *response;
    if ([source.title isEqualToString:DTVC_FIRE_STATS])  {
        response = @"Fire";
    } else if ([source.title isEqualToString:DTVC_AIR_STATS])  {
        response = @"Air";
    } else if ([source.title isEqualToString:DTVC_WATER_STATS]) {
        response = @"Water";
    } else if ([source.title isEqualToString:DTVC_EARTH_STATS]) {
        response = @"Earth";
    } else if ([source.title isEqualToString:DTVC_CHI_STATS]) {
        response = @"Chi";
    }
    return response;
}

- (NSString *)primaryStatValueForDisplay:(StatTableViewController *)source
{
    [self logRequestFromStatTableViewController:source];
    
    NSNumber *response;
    if ([source.title isEqualToString:DTVC_FIRE_STATS]) {
        response = [[self.characterData primaryStats] valueForKey:CHARACTER_PRIMARY_FEROCITY];
    } else if ([source.title isEqualToString:DTVC_AIR_STATS]) {
        response = [[self.characterData primaryStats] valueForKey:CHARACTER_PRIMARY_ACCURACY];
    } else if ([source.title isEqualToString:DTVC_WATER_STATS]) {
        response = [[self.characterData primaryStats] valueForKey:CHARACTER_PRIMARY_AGILITY];
    } else if ([source.title isEqualToString:DTVC_EARTH_STATS]) {
        response = [[self.characterData primaryStats] valueForKey:CHARACTER_PRIMARY_RESILIENCE];
    } else if ([source.title isEqualToString:DTVC_CHI_STATS]) {
        response = [[self.characterData primaryStats] valueForKey:CHARACTER_PRIMARY_CHI];
    }
    
    if (response) {
        return [NSString stringWithFormat:@"%@", response];
    } else {
        return nil;
    }
}

- (NSString *)headingForDisplay:(StatTableViewController *)source
{
    [self logRequestFromStatTableViewController:source];
    
    NSString *response;
    if ([source.title isEqualToString:DTVC_SOUL]) {
        response = @"Soul";
    } else if ([source.title isEqualToString:DTVC_PRIMARY]) {
        response = @"Primary Stats";
    } else if ([source.title isEqualToString:DTVC_FIRE_STATS]) {
        response = @"Fire";
    } else if ([source.title isEqualToString:DTVC_AIR_STATS]) {
        response = @"Air";
    } else if ([source.title isEqualToString:DTVC_WATER_STATS]) {
        response = @"Water";
    } else if ([source.title isEqualToString:DTVC_EARTH_STATS]) {
        response = @"Earth";
    } else if ([source.title isEqualToString:DTVC_CHI_STATS]) {
        response = @"Chi";
    }
    return response;
}

- (NSOrderedSet *)dataForDisplay:(StatTableViewController *)source
{
    [self logRequestFromStatTableViewController:source];
    
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
    } else if ([source.title isEqualToString:DTVC_CHI_STATS]) {
        orderedStatList = nil;
    }

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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)logRequestFromStatTableViewController:(StatTableViewController *)controller {
    if (![self.statTableViewControllers containsObject:controller]) {
        [self.statTableViewControllers addObject:controller];
    }
}

- (void)swipeHandler:(UISwipeGestureRecognizer *)gesture {
    [self.statTableViewControllers enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        StatTableViewController *controller = obj;
        controller.hideTableData = !controller.hideTableData;
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
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
