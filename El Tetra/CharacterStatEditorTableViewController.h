//
//  CharacterStatEditorTableViewController.h
//  El Tetra
//
//  Created by Matthew Kameron on 30/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterStatPresenter.h"
#import "CharacterStatEditorTableViewCell.h"

@class CharacterStatEditorTableViewController;

@protocol CharacterStatEditorTableViewControllerDataSource <NSObject>
- (CharacterStatPresenter *)characterStatData:(CharacterStatEditorTableViewController *)source;
@end

@interface CharacterStatEditorTableViewController : UITableViewController <CharacterStatEditorTableViewCellDelegate>
@property (nonatomic, weak) id<CharacterStatEditorTableViewControllerDataSource> dataSource;
@end
