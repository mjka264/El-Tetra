//
//  StatTableViewController.h
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StatTableViewController;
@class TableViewControllerData;




@protocol StatTableViewControllerDataSource <NSObject>
// The data for the following line is a set of sets
// The outer set is the section
// The inner set is the stat within the section
- (NSOrderedSet *)dataForStatTVC:(StatTableViewController *)StatTVC;
@end



@interface StatTableViewController : UITableViewController
@property (nonatomic, weak) id <StatTableViewControllerDataSource> dataSource;

@end



@interface StatTableViewControllerData : NSObject
@property (nonatomic, strong) NSString *characterisic;
@property (nonatomic) NSInteger value;
+ (StatTableViewControllerData *)dataWithValue:(NSInteger)value forCharacteristic:(NSString *)characteristic;
@end



