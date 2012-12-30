//
//  StatTableViewController.h
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatTableViewHeader.h"
#import "CharacterStatPresenter.h"

@class StatTableViewController;
@class TableViewControllerData;

@protocol StatTableViewControllerDataSource <NSObject>
- (CharacterStatPresenter *)characterStatsFrom:(StatTableViewController *)source;
@end

@interface StatTableViewController : UITableViewController <ColouredCircleAndHeaderDataSource>
@property (nonatomic) BOOL hideTableData;
@property (nonatomic, weak) id <StatTableViewControllerDataSource> dataSource;
@end

