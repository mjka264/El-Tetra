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
@property (nonatomic, strong) CharacterData *characterData;
@property (nonatomic, strong) NSDictionary *controllerIdentityStatGroups;
@end


@implementation CharacterSheetSkillsViewController


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
    }
}

@end
