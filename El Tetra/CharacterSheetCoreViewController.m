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

#define SUBVIEW_TAG_SOUL 0
#define SUBVIEW_TAG_FIRE 1
#define SUBVIEW_TAG_AIR 2
#define SUBVIEW_TAG_WATER 3
#define SUBVIEW_TAG_EARTH 4
#define SUBVIEW_TAG_CHI 5


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

- (void)swipeHandlerRight:(UISwipeGestureRecognizer *)gesture {
    [self.statTableViewControllers enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        StatTableViewController *controller = obj;
        controller.hideTableData = YES;
    }];
    
    for (UIView *subview in self.view.subviews) {
        if (subview.tag == SUBVIEW_TAG_SOUL) {
            subview.frame = CGRectZero;
        } else if (subview.tag >= SUBVIEW_TAG_FIRE && subview.tag <= SUBVIEW_TAG_CHI) {
            subview.frame = CGRectMake(0,subview.tag*40-40,134,40);
        }
    }
}

- (void)swipeHandlerLeft:(UISwipeGestureRecognizer *)gesture {
    [self.statTableViewControllers enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        StatTableViewController *controller = obj;
        controller.hideTableData = NO;
    }];
    
    for (UIView *subview in self.view.subviews) {
        if (subview.tag == SUBVIEW_TAG_SOUL) {
            subview.frame = CGRectMake(93,1,134,100);
        } else if (subview.tag == SUBVIEW_TAG_FIRE) {
            subview.frame = CGRectMake(0,109,134,100);
        } else if (subview.tag == SUBVIEW_TAG_AIR) {
            subview.frame = CGRectMake(186,109,134,100);
        } else if (subview.tag == SUBVIEW_TAG_WATER) {
            subview.frame = CGRectMake(0,217,134,100);
        } else if (subview.tag == SUBVIEW_TAG_EARTH) {
            subview.frame = CGRectMake(186,217,134,100);
        } else if (subview.tag == SUBVIEW_TAG_CHI) {
            subview.frame = CGRectMake(90,325,140,41);
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandlerRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandlerLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
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
