//
//  CharacterSheetCoreViewController.h
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatTableViewController.h"

@interface CharacterSheetSkillsViewController : UIViewController <StatTableViewControllerDataSource>
- (NSOrderedSet *)dataForDisplay:(StatTableViewController *)source;
@end


#define DTVC_SOUL @"SoulStatsController"
#define DTVC_PRIMARY @"PrimaryStatsController"
#define DTVC_FIRE_STATS @"FireStatsController"
#define DTVC_AIR_STATS @"AirStatsController"
#define DTVC_WATER_STATS @"WaterStatsController"
#define DTVC_EARTH_STATS @"EarthStatsController"
#define DTVC_CHI_STATS @"ChiStatsController"

#define SUBVIEW_TAG_SOUL 0
#define SUBVIEW_TAG_FIRE 1
#define SUBVIEW_TAG_AIR 2
#define SUBVIEW_TAG_WATER 3
#define SUBVIEW_TAG_EARTH 4
#define SUBVIEW_TAG_CHI 5