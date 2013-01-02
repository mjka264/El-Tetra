//
//  CharacterSkillsSummaryViewController.m
//  El Tetra
//
//  Created by Matthew Kameron on 30/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterSkillsSummaryViewController.h"
#import "CharacterStatPresenter.h"
#import "CharacterSelecterProtocol.h"


@interface CharacterSkillsSummaryViewController ()
@property (nonatomic, strong) NSMutableDictionary *statPresenters;  // Stores the stat presentor for each sub-controller
@property (nonatomic, readonly) CharacterStatPresenter *characterStats;
@end

@implementation CharacterSkillsSummaryViewController
@synthesize dataSource = _dataSource;
- (CharacterStatPresenter *)characterStats {
    return [self.dataSource dataSourceCharacterStatsPresenter:self];
}

@synthesize statPresenters = _statPresenters;
- (NSMutableDictionary *)statPresenters {
    if (_statPresenters) _statPresenters = [[NSMutableDictionary alloc] init];
    return _statPresenters;
}

- (NSInteger)convertDescriptionToElement:(NSString *)text {
    NSInteger element = 0;
    if ([text isEqualToString:@"FireStatsController"]) element = CharacterStatElementFire;
    else if ([text isEqualToString:@"AirStatsController"]) element = CharacterStatElementAir;
    else if ([text isEqualToString:@"WaterStatsController"]) element = CharacterStatElementWater;
    else if ([text isEqualToString:@"EarthStatsController"]) element = CharacterStatElementEarth;
    else if ([text isEqualToString:@"ChiStatsController"]) element = CharacterStatElementChi;
    return element;
}

- (CharacterStatPresenter *)characterStatsFrom:(StatTableViewController *)source {
    NSString *title = source.title;
    if ([[self.statPresenters allKeys] containsObject:title]) {
        return [self.statPresenters objectForKey:title];
    } else {
        CharacterStatPresenter *presenter;
        NSInteger element = [self convertDescriptionToElement:title];
        if (element) {
            presenter = [self.characterStats statPresenterMatchingCriteriaGroup:CharacterStatGroupSkills
                                                                        element:element
                                                                           soul:0
                                                             includeHeadingStat:YES];
        } else {
            presenter = [self.characterStats statPresenterMatchingCriteriaGroup:CharacterStatGroupSoul
                                                                        element:0
                                                                           soul:0
                                                             includeHeadingStat:NO];
        }
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
