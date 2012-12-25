//
//  CharacterSheetAbilitiesViewController.m
//  El Tetra
//
//  Created by Matthew Kameron on 25/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterSheetAbilitiesViewController.h"

@interface CharacterSheetAbilitiesViewController ()

@end

@implementation CharacterSheetAbilitiesViewController
@synthesize soulStatBody = _soulStatBody;
@synthesize soulStatMind = _soulStatMind;
@synthesize soulStatSpirit = _soulStatSpirit;
/*
- (NSOrderedSet *)dataForDisplay:(StatTableViewController *)source
{
    if ([source.title isEqualToString:DTVC_SOUL] ||
        [source.title isEqualToString:DTVC_ABILITY_STATS]) {
        return [super dataForDisplay:source];
    } else {
        return nil;
    }
}

- (NSString *)headingForDisplay:(StatTableViewController *)source
{
    NSString *response = [super headingForDisplay:source];
    
    if ([source.title isEqualToString:DTVC_SOUL]) {
        response = @"Soul";
    } else if ([source.title isEqualToString:DTVC_FIRE_STATS]) {
        response = @"Ferocity";
    } else if ([source.title isEqualToString:DTVC_AIR_STATS]) {
        response = @"Precision";
    } else if ([source.title isEqualToString:DTVC_WATER_STATS]) {
        response = @"Agility";
    } else if ([source.title isEqualToString:DTVC_EARTH_STATS]) {
        response = @"Resilience";
    } else if ([source.title isEqualToString:DTVC_CHI_STATS]) {
        response = @"Chi";
    }
    return response;
}

- (void)viewWillAppear:(BOOL)animated {
    NSDictionary *stats = [super.characterData soulStats];
    self.soulStatBody.text = [NSString stringWithFormat:@"%@",[stats objectForKey:CHARACTER_SOUL_BODY]];
    self.soulStatMind.text = [NSString stringWithFormat:@"%@",[stats objectForKey:CHARACTER_SOUL_MIND]];
    self.soulStatSpirit.text = [NSString stringWithFormat:@"%@",[stats objectForKey:CHARACTER_SOUL_SPIRIT]];
}
*/
- (void)setupSelf {

}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupSelf];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSelf];
}

@end
