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

- (NSInteger)convertDescriptionToElement:(NSString *)text {
    if ([text isEqualToString:@"FireStatsController"]) return CharacterStatElementFire;
    else if ([text isEqualToString:@"AirStatsController"]) return CharacterStatElementAir;
    else if ([text isEqualToString:@"WaterStatsController"]) return CharacterStatElementWater;
    else if ([text isEqualToString:@"EarthStatsController"]) return CharacterStatElementEarth;
    else if ([text isEqualToString:@"ChiStatsController"]) return CharacterStatElementChi;
    else return 0;
}

- (CharacterStatPresenter *)characterStatsFrom:(StatTableViewController *)source {
    NSString *title = source.title;
    if ([[self.statPresenters allKeys] containsObject:title]) {
        return [self.statPresenters objectForKey:title];
    } else {
        CharacterStatPresenter *presenter;
        NSInteger element = [self convertDescriptionToElement:title];
        presenter = [self.characterStats statPresenterMatchingCriteriaGroup:0
                                                                    element:element
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
