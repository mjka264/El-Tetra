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

- (NSOrderedSet *)dataForDisplay:(StatTableViewController *)source
{
    if ([source.title isEqualToString:DTVC_SOUL]) {
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


@end
