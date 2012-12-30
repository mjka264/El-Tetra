//
//  CharacterSkillsSummaryViewController.m
//  El Tetra
//
//  Created by Matthew Kameron on 30/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterSkillsSummaryViewController.h"
#import "CharacterStatPresenter.h"

@interface CharacterSkillsSummaryViewController ()
@property (nonatomic, strong) NSMutableDictionary *statPresenters;  // Stores the stat presentor for each sub-controller
@property (nonatomic, readonly) CharacterStatPresenter *characterStats;
@end

@implementation CharacterSkillsSummaryViewController
@synthesize dataSource = _dataSource;
- (CharacterStatPresenter *)characterStats {
    return [self.dataSource dataSourceCharacterStatsFor:self];
}

@synthesize statPresenters = _statPresenters;
- (NSMutableDictionary *)statPresenters {
    if (_statPresenters) _statPresenters = [[NSMutableDictionary alloc] init];
    return _statPresenters;
}
/*
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
 */

- (CharacterStatPresenter *)characterStatsFrom:(StatTableViewController *)source {
    if ([[self.statPresenters allKeys] containsObject:source.description]) {
        return [self.statPresenters objectForKey:source];
    } else {
        CharacterStatPresenter *presenter = [self.characterStats statPresenterMatchingCriteriaGroup:0
                                                                                            element:CharacterStatElementAir
                                                                                               soul:0];
        [self.statPresenters setObject:presenter forKey:source.description];
        return presenter;
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[StatTableViewController class]]) {
        StatTableViewController *destination = segue.destinationViewController;
        destination.dataSource = self;
    }
}

@end
