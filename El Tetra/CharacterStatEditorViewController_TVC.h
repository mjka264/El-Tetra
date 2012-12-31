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

@class CharacterStatEditorViewController_TVC;

@protocol CharacterStatEditorTableViewControllerDataSource <NSObject>
- (CharacterStatPresenter *)characterStatData:(CharacterStatEditorViewController_TVC *)source;
@end

@interface CharacterStatEditorViewController_TVC : UIViewController <CharacterStatEditorTableViewCellDelegate>
@property (nonatomic, weak) id<CharacterStatEditorTableViewControllerDataSource> dataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *characterStatsSummaryView;
@end
