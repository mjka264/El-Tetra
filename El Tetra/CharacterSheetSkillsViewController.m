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
