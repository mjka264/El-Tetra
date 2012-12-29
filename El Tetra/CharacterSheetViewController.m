//
//  CharacterSheetCoreViewController.m
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterSheetViewController.h"
#import "CharacterStats.h"
#import "CharacterLoadoutViewController.h"
#import "CharacterLoadout.h"

@interface CharacterSheetViewController ()
@property (nonatomic, strong) CharacterStats *characterStats;
@property (nonatomic, strong) NSDictionary *controllerIdentityStatGroups;


// Controller bits needed for the loadout stuff
@property (nonatomic, strong) NSMutableArray *characterLoadouts; // of CharacterLoadout
//@property (nonatomic, weak) UIStoryboard *storyBoard;            // used to make the controllers

@end


@implementation CharacterSheetViewController

@synthesize soulStatBody = _soulStatBody;
- (void)setSoulStatBody:(UILabel *)soulStatBody {
    if (_soulStatBody != soulStatBody) {
        _soulStatBody = soulStatBody;
        _soulStatBody.text = [NSString stringWithFormat:@"%@", [CharacterStats soulStatFrom:self.characterStats forStat:CharacterStatSoulBody]];
    }
}
@synthesize soulStatMind = _soulStatMind;
- (void)setSoulStatMind:(UILabel *)soulStatMind {
    if (_soulStatMind != soulStatMind) {
        _soulStatMind = soulStatMind;
        _soulStatMind.text = [NSString stringWithFormat:@"%@", [CharacterStats soulStatFrom:self.characterStats forStat:CharacterStatSoulMind]];
    }
}
@synthesize soulStatSpirit = _soulStatSpirit;
- (void)setSoulStatSpirit:(UILabel *)soulStatSpirit {
    if (_soulStatSpirit != soulStatSpirit) {
        _soulStatSpirit = soulStatSpirit;
        _soulStatSpirit.text = [NSString stringWithFormat:@"%@", [CharacterStats soulStatFrom:self.characterStats forStat:CharacterStatSoulSpirit]];
    }
}

- (CharacterStats *)characterData:(UIViewController *)source {
    return [self.characterStats characterWithStatGroup:
            [[self.controllerIdentityStatGroups objectForKey:source.title] integerValue]];
}

// This identifies the controller names in the UI and convert them to CharacterData's language
@synthesize controllerIdentityStatGroups = _controllerIdentityStatGroups;
- (NSDictionary *)controllerIdentityStatGroups {
    if (!_controllerIdentityStatGroups) {
        _controllerIdentityStatGroups = [NSDictionary dictionaryWithObjectsAndKeys:
                                         [NSNumber numberWithInt:CharacterStatGroupSoul],
                                         @"SoulStatsController",
                                         [NSNumber numberWithInt:CharacterStatGroupPrimary],
                                         @"PrimaryStatsController",
                                         [NSNumber numberWithInt:CharacterStatGroupFireSkills],
                                         @"FireStatsController",
                                         [NSNumber numberWithInt:CharacterStatGroupAirSkills],
                                         @"AirStatsController",
                                         [NSNumber numberWithInt:CharacterStatGroupWaterSkills],
                                         @"WaterStatsController",
                                         [NSNumber numberWithInt:CharacterStatGroupEarthSkills],
                                         @"EarthStatsController",
                                         [NSNumber numberWithInt:CharacterStatGroupChiSkills],
                                         @"ChiStatsController",
                                         [NSNumber numberWithInt:CharacterStatGroupAbilities],
                                         @"AbilityStatsController", nil];
    }
    return _controllerIdentityStatGroups;
}


@synthesize characterStats = _characterStats;
- (CharacterStats *)characterStats
{
    if (!_characterStats) _characterStats = [[CharacterStats alloc] init];
    return _characterStats;
}


#pragma mark -
#pragma mark CharacterLoadout (PageViewController protocol)

@synthesize characterLoadouts = _characterLoadouts;
- (NSMutableArray *)characterLoadouts {
    if (!_characterLoadouts) {
        _characterLoadouts = [NSMutableArray arrayWithObjects:
                              [CharacterLoadout defaultLoadout],
                              [CharacterLoadout defaultLoadout],
                              nil];
    }
    return _characterLoadouts;
}

- (CharacterLoadoutViewController *)loadoutControllerAtIndex:(NSInteger)index {
    if ([self.characterLoadouts count] == 0 ||
        index >= [self.characterLoadouts count] ||
        index < 0) {
        return nil;
    }
    
    CharacterLoadoutViewController *loadoutController = [self.storyboard instantiateViewControllerWithIdentifier:@"CharacterLoadoutViewControllerTemplate"];
    
    loadoutController.characterLoadout = [self.characterLoadouts objectAtIndex:index];
    loadoutController.dataSource = self;
    
    return loadoutController;
}

- (NSUInteger)indexOfLoadoutController:(CharacterLoadoutViewController *)loadoutController
{
    return [self.characterLoadouts indexOfObject:loadoutController.characterLoadout];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(CharacterLoadoutViewController *)loadoutController
{
    NSInteger index = [self indexOfLoadoutController: loadoutController] - 1;
    if (index != NSNotFound) return [self loadoutControllerAtIndex:index];
    else return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(CharacterLoadoutViewController *)loadoutController
{
    NSInteger index = [self indexOfLoadoutController: loadoutController] + 1;
    if (index != NSNotFound) return [self loadoutControllerAtIndex:index];
    else return nil;
}


#pragma mark -
#pragma mark CharacterLoadoutViewControllerDataSource

- (id)dataSourceCharacterStats:(CharacterLoadoutViewController *)sender {
    return  self.characterStats;
}


NSInteger _indexOfCurrentLoadoutViewControllerForManagingLoadouts;

- (void)createNewCharacterLoadout:(CharacterLoadoutViewController *)sender {
    _indexOfCurrentLoadoutViewControllerForManagingLoadouts = [self indexOfLoadoutController:sender];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New Loadout"
                                                     message:nil
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"Save", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].placeholder = @"Title";
    [alert show];
    
}


- (void)deleteCurrentCharacterLoadout:(CharacterLoadoutViewController *)sender {
}
/*    _indexOfCurrentLoadoutViewControllerForManagingLoadouts = [self indexOfLoadoutController:sender];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:@"Delete Loadout"
                                              otherButtonTitles:nil];
}*/

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    return [[alertView textFieldAtIndex:0].text length] > 0;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSUInteger newIndex = 1 + _indexOfCurrentLoadoutViewControllerForManagingLoadouts;
        CharacterLoadout *newLoadout = [[self.characterLoadouts objectAtIndex:_indexOfCurrentLoadoutViewControllerForManagingLoadouts] copy];
        newLoadout.name = [alertView textFieldAtIndex:0].text;
        [self.characterLoadouts insertObject:newLoadout atIndex:newIndex];
        CharacterLoadoutViewController *newController = [self loadoutControllerAtIndex:newIndex];
        [self.pageViewController setViewControllers:[NSArray arrayWithObject:newController]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:YES
                                         completion:^(BOOL finished) {
                                             UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"This is an example alert!" delegate:self cancelButtonTitle:@"Hide" otherButtonTitles:nil];
                                             alert.alertViewStyle = UIAlertViewStylePlainTextInput;
                                             [newController initiateSegueEditLoadout];
                                         }];
    } // otherwise they must have pressed cancel
}

#pragma mark -
#pragma mark prepareForSegue - Passes data onto the included controllers


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[StatTableViewController class]]) {
        StatTableViewController *destination = segue.destinationViewController;
        destination.dataSource = self;
    } else if ([segue.destinationViewController isKindOfClass:[UIPageViewController class]]) {
        UIPageViewController *destination = segue.destinationViewController;
        self.pageViewController = destination;
        destination.dataSource = self;
        
        CharacterLoadoutViewController *initialLoadoutController =
        [self loadoutControllerAtIndex:0];
        NSArray *viewControllers = [NSArray arrayWithObject:initialLoadoutController];
        
        [destination setViewControllers:viewControllers
                                 direction:UIPageViewControllerNavigationDirectionForward
                                  animated:NO
                                completion:nil];
    }
}


@end
