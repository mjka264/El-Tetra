//
//  CharacterSheetCoreViewController.m
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterSheetViewController.h"
#import "CharacterData.h"
#import "CharacterLoadoutViewController.h"

@interface CharacterSheetViewController ()
@property (nonatomic, strong) CharacterData *characterData;
@property (nonatomic, strong) NSDictionary *controllerIdentityStatGroups;
@end


@implementation CharacterSheetViewController

// init done - first setup for WWW page modified
@synthesize pageViewContent = _pageViewContent;
- (NSArray *) pageViewContent {
    if (!_pageViewContent) _pageViewContent = [NSArray arrayWithObjects:@"AAA", @"BBB", @"CCC", @"DDD", nil];
    return _pageViewContent;
}
@synthesize pageViewController = _pageViewController;


// Convenience methods
- (CharacterLoadoutViewController *)viewControllerAtIndex:(NSUInteger)index
{
    // Return the data view controller for the given index.
    if (([self.pageViewContent count] == 0) ||
        (index >= [self.pageViewContent count])) {
        return nil;
    }
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                         bundle:nil];
    
    
    // Create a new view controller and pass suitable data.
    CharacterLoadoutViewController *loadoutController = [storyBoard instantiateViewControllerWithIdentifier:@"CharacterLoadoutViewControllerTemplate"];
    
    loadoutController.dataObject =
    [self.pageViewContent objectAtIndex:index];
    return loadoutController;
}

- (NSUInteger)indexOfViewController:(CharacterLoadoutViewController *)viewController
{
    return [self.pageViewContent indexOfObject:viewController.dataObject];
}

// Now the protocol:

- (UIViewController *)pageViewController:
(UIPageViewController *)pageViewController viewControllerBeforeViewController:
(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:
                        (CharacterLoadoutViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:
(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:
                        (CharacterLoadoutViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageViewContent count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}









@synthesize soulStatBody = _soulStatBody;
- (void)setSoulStatBody:(UILabel *)soulStatBody {
    if (_soulStatBody != soulStatBody) {
        _soulStatBody = soulStatBody;
        _soulStatBody.text = [NSString stringWithFormat:@"%@", [CharacterData soulStatFrom:self.characterData forStat:CharacterDataSoulStatBody]];
    }
}
@synthesize soulStatMind = _soulStatMind;
- (void)setSoulStatMind:(UILabel *)soulStatMind {
    if (_soulStatMind != soulStatMind) {
        _soulStatMind = soulStatMind;
        _soulStatMind.text = [NSString stringWithFormat:@"%@", [CharacterData soulStatFrom:self.characterData forStat:CharacterDataSoulStatMind]];
    }
}
@synthesize soulStatSpirit = _soulStatSpirit;
- (void)setSoulStatSpirit:(UILabel *)soulStatSpirit {
    if (_soulStatSpirit != soulStatSpirit) {
        _soulStatSpirit = soulStatSpirit;
        _soulStatSpirit.text = [NSString stringWithFormat:@"%@", [CharacterData soulStatFrom:self.characterData forStat:CharacterDataSoulStatSpirit]];
    }
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[StatTableViewController class]]) {
        StatTableViewController *destination = segue.destinationViewController;
        destination.dataSource = self;
    } else if ([segue.destinationViewController isKindOfClass:[UIPageViewController class]]) {
        UIPageViewController *destination = segue.destinationViewController;
        destination.dataSource = self;
        
        CharacterLoadoutViewController *initialLoadoutController =
        [self viewControllerAtIndex:0];
        NSArray *viewControllers =
        [NSArray arrayWithObject:initialLoadoutController];
        
        [destination setViewControllers:viewControllers
                                 direction:UIPageViewControllerNavigationDirectionForward
                                  animated:NO
                                completion:nil];
    }
}

@end
