//
//  CharacterSheetCoreViewController.m
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterSheetSkillsViewController.h"
#import "CharacterData.h"


@interface CharacterSheetSkillsViewController ()
@property (nonatomic, strong) NSMutableSet *statTableViewControllers;
@property (nonatomic, strong) CharacterData *characterData;
- (void)logRequestFromStatTableViewController:(StatTableViewController *)controller;
@property (nonatomic, strong) NSDictionary *controllerIdentityStatGroups;
@end




@implementation CharacterSheetSkillsViewController
@synthesize statTableViewControllers = _statTableViewControllers;
- (NSMutableSet *)statTableViewControllers {
    if (!_statTableViewControllers) {
        _statTableViewControllers = [[NSMutableSet alloc] init];
    }
    return _statTableViewControllers;
}

- (CharacterData *)characterData:(UIViewController *)source {
    NSLog(@"%@", source.title);
    return [self.characterData characterWithStatGroup:
            [[self.controllerIdentityStatGroups objectForKey:source.title] integerValue]];
}

// This identifies the controller names in the UI and convert them to CharacterData's language
@synthesize controllerIdentityStatGroups = _controllerIdentityStatGroups;
- (NSDictionary *)controllerIdentityStatGroups {
    if (!_controllerIdentityStatGroups) {
        _controllerIdentityStatGroups = [NSDictionary dictionaryWithObjectsAndKeys:
                                         [NSNumber numberWithInt:CharacterDataStatGroupSoul],
                                         @"SoulStatsController",
                                         [NSNumber numberWithInt:CharacterDataStatGroupPrimary],
                                         @"PrimaryStatsController",
                                         [NSNumber numberWithInt:CharacterDataStatGroupFireSkills],
                                         @"FireStatsController",
                                         [NSNumber numberWithInt:CharacterDataStatGroupAirSkills],
                                         @"AirStatsController",
                                         [NSNumber numberWithInt:CharacterDataStatGroupWaterSkills],
                                         @"WaterStatsController",
                                         [NSNumber numberWithInt:CharacterDataStatGroupEarthSkills],
                                         @"EarthStatsController",
                                         [NSNumber numberWithInt:CharacterDataStatGroupChiSkills],
                                         @"ChiStatsController",
                                         [NSNumber numberWithInt:CharacterDataStatGroupAbilities],
                                         @"AbilityStatsController", nil];
    }
    return _controllerIdentityStatGroups;
}


@synthesize characterData = _characterData;
- (CharacterData *)characterData
{
    if (!_characterData) _characterData = [[CharacterData alloc] init];
    return _characterData;
}


/*
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
    NSOrderedSet *orderedStatLists; // The 2d set referring to the order in which they should be presented
    
    // These ifs load the correct data from the model
    if ([source.title isEqualToString:DTVC_SOUL]) {
        stats = [self.characterData soulStats];
        orderedStatLists = [NSOrderedSet orderedSetWithObject:[CharacterData soulStatsPresentationOrder]];
    } else if ([source.title isEqualToString:DTVC_PRIMARY]) {
        stats = [self.characterData primaryStats];
        orderedStatLists = [NSOrderedSet orderedSetWithObject:[CharacterData primaryStatsPresentationOrder]];
    } else if ([source.title isEqualToString:DTVC_FIRE_STATS]) {
        stats = [self.characterData skillStats];
        orderedStatLists = [NSOrderedSet orderedSetWithObject:[CharacterData fireSkillsPresentationOrder]];
    } else if ([source.title isEqualToString:DTVC_AIR_STATS]) {
        stats = [self.characterData skillStats];
        orderedStatLists = [NSOrderedSet orderedSetWithObject:[CharacterData airSkillsPresentationOrder]];
    } else if ([source.title isEqualToString:DTVC_WATER_STATS]) {
        stats = [self.characterData skillStats];
        orderedStatLists = [NSOrderedSet orderedSetWithObject:[CharacterData waterSkillsPresentationOrder]];
    } else if ([source.title isEqualToString:DTVC_EARTH_STATS]) {
        stats = [self.characterData skillStats];
        orderedStatLists = [NSOrderedSet orderedSetWithObject:[CharacterData earthSkillsPresentationOrder]];
    } else if ([source.title isEqualToString:DTVC_ABILITY_STATS]) {
        stats = [self.characterData abilityStats];
        orderedStatLists = [NSOrderedSet orderedSetWithObjects:
                            [CharacterData fireAbilitiesPresentationOrder],
                            [CharacterData airAbilitiesPresentationOrder],
                            [CharacterData waterAbilitiesPresentationOrder],
                            [CharacterData earthAbilitiesPresentationOrder],
                            [CharacterData chiAbilitiesPresentationOrder], nil];
    } else if ([source.title isEqualToString:DTVC_CHI_STATS]) {
        orderedStatLists = nil;
    }

    // Now build the orderStats list with the correct things.
    // Store this data in StatTableViewControllerData objects, as requested by StatTableViewController
    NSMutableOrderedSet *metaset = [[NSMutableOrderedSet alloc] init];
    for (NSOrderedSet *eachOrderedList in orderedStatLists) {
        NSMutableOrderedSet *orderedStats = [[NSMutableOrderedSet alloc] init]; // what we are building
        for (NSString *statName in eachOrderedList) {
            if ([stats valueForKey:statName]) {
                [orderedStats addObject:[StatTableViewControllerData
                                         dataWithValue:[[stats valueForKey:statName] integerValue]
                                         forCharacteristic:statName]];
            }
        }
        [metaset addObject:[orderedStats copy]];
    }
    return [metaset copy];
}
*/

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

/*
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
 */

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
