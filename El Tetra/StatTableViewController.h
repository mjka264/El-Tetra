//
//  StatTableViewController.h
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ElTetraProtocols.h"

@class StatTableViewController;
@class TableViewControllerData;


#define STAT_MODE_ABILITIES @"Ability Mode"
#define STAT_MODE_SKILLS @"Skill Mode"


// BUG SET TO WEAK
@interface StatTableViewController : UITableViewController
@property (nonatomic) BOOL hideTableData;
@property (nonatomic, strong) NSString *statMode;
@property (nonatomic, strong) id <StatTableViewControllerDataSource> dataSource;
@end



@interface StatTableViewControllerData : NSObject
@property (nonatomic, strong) NSString *characterisic;
@property (nonatomic) NSInteger value;
+ (StatTableViewControllerData *)dataWithValue:(NSInteger)value forCharacteristic:(NSString *)characteristic;
@end



