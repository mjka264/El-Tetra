//
//  CharacterSheetCoreViewController.m
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterSheetViewController.h"
#import "CharacterStatPresenter.h"
#import "CharacterLoadoutViewController.h"
#import "CharacterLoadout.h"

@interface CharacterSheetViewController ()
@property (nonatomic, strong) NSDictionary *controllerIdentityStatGroups;

// data Source links
@property (nonatomic, strong, readonly) CharacterStatPresenter *characterStats;
@property (nonatomic, strong, readonly) NSMutableArray *characterLoadouts; // of CharacterLoadout

@end


@implementation CharacterSheetViewController

@synthesize soulStatBody = _soulStatBody;
- (void)setSoulStatBody:(UILabel *)soulStatBody {
    if (_soulStatBody != soulStatBody) {
        _soulStatBody = soulStatBody;
        _soulStatBody.text = [NSString stringWithFormat:@"%@", [CharacterStatPresenter soulStatFrom:self.characterStats forStat:CharacterStatSoulBody]];
    }
}
@synthesize soulStatMind = _soulStatMind;
- (void)setSoulStatMind:(UILabel *)soulStatMind {
    if (_soulStatMind != soulStatMind) {
        _soulStatMind = soulStatMind;
        _soulStatMind.text = [NSString stringWithFormat:@"%@", [CharacterStatPresenter soulStatFrom:self.characterStats forStat:CharacterStatSoulMind]];
    }
}
@synthesize soulStatSpirit = _soulStatSpirit;
- (void)setSoulStatSpirit:(UILabel *)soulStatSpirit {
    if (_soulStatSpirit != soulStatSpirit) {
        _soulStatSpirit = soulStatSpirit;
        _soulStatSpirit.text = [NSString stringWithFormat:@"%@", [CharacterStatPresenter soulStatFrom:self.characterStats forStat:CharacterStatSoulSpirit]];
    }
}

- (CharacterStatPresenter *)characterStats:(UIViewController *)source {
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

- (CharacterStatPresenter *)characterStats
{
    return [self.dataSource characterData:self].stats;
}


#pragma mark -
#pragma mark CharacterLoadout (PageViewController protocol)

@synthesize characterLoadouts = _characterLoadouts;
- (NSMutableArray *)characterLoadouts {
    return [self.dataSource characterData:(self)].loadouts;
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

- (NSInteger)indexOfLoadoutController:(CharacterLoadoutViewController *)loadoutController
{
    NSInteger num = [self.characterLoadouts indexOfObject:loadoutController.characterLoadout];
    return num;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(CharacterLoadoutViewController *)loadoutController
{
    NSInteger index = [self indexOfLoadoutController: loadoutController];
    if (index != NSNotFound) return [self loadoutControllerAtIndex:(index-1)];
    else return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(CharacterLoadoutViewController *)loadoutController
{
    NSInteger index = [self indexOfLoadoutController: loadoutController];
    if (index != NSNotFound) return [self loadoutControllerAtIndex:(index+1)];
    else return nil;
}


#pragma mark -
#pragma mark CharacterLoadoutViewControllerDataSource

- (id)dataSourceCharacterStats:(CharacterLoadoutViewController *)sender {
    return self.characterStats;
}


- (void)createNewCharacterLoadout:(CharacterLoadoutViewController *)sender withName:(NSString *)loadoutName {
    NSUInteger newIndex = 1 + [self indexOfLoadoutController:sender];
    CharacterLoadout *newLoadout = [[self.characterLoadouts objectAtIndex:[self indexOfLoadoutController:sender]] copy];
    newLoadout.name = loadoutName;
    [self.characterLoadouts insertObject:newLoadout atIndex:newIndex];
    CharacterLoadoutViewController *newController = [self loadoutControllerAtIndex:newIndex];
    [self.pageViewController setViewControllers:[NSArray arrayWithObject:newController]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:^(BOOL finished) {
                                         [newController initiateSegueEditLoadout];
                                     }];
}

// I would have liked to have used the built-in PageView animation here
// But it had issues to do with remembering the left/right view controllers
// which led to the user seeing blankish loadouts.
- (void)deleteCurrentCharacterLoadout:(CharacterLoadoutViewController *)sender {
    NSUInteger deletingIndex = [self indexOfLoadoutController:sender];
    NSUInteger newIndex;

    if (deletingIndex > 0) newIndex = deletingIndex - 1;
    else newIndex = deletingIndex;
    [self.characterLoadouts removeObjectAtIndex:deletingIndex];
    
    [UIView transitionWithView:sender.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:nil
                    completion:^(BOOL finished) {
                        [self.pageViewController setViewControllers:[NSArray arrayWithObject:[self loadoutControllerAtIndex:newIndex]]
                                                          direction:UIPageViewControllerNavigationDirectionForward
                                                           animated:NO
                                                         completion:nil];
                    }];
}

- (BOOL)shouldEnableDeleteLoadoutButton:(CharacterLoadoutViewController *)sender {
    return [self.characterLoadouts count] > 1;
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
        destination.delegate = self;
        
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
