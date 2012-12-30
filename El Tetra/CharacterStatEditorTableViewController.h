//
//  CharacterStatEditorTableViewController.h
//  El Tetra
//
//  Created by Matthew Kameron on 30/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterStats.h"

@class CharacterStatEditorTableViewController;

@protocol CharacterStatEditorTableViewControllerDataSource <NSObject>
- (CharacterStats *)characterStatData:(CharacterStatEditorTableViewController *)source;
@end

@interface CharacterStatEditorTableViewController : UITableViewController
@property (nonatomic, weak) id<CharacterStatEditorTableViewControllerDataSource> dataSource;
@end
