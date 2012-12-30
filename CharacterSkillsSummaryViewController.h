//
//  CharacterSkillsSummaryViewController.h
//  El Tetra
//
//  Created by Matthew Kameron on 30/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatTableViewController.h"

@class CharacterSkillsSummaryViewController;

@protocol CharacterSkillsSummaryViewControllerDataSource <NSObject>
- (CharacterStatPresenter *)dataSourceCharacterStatsFor:(CharacterSkillsSummaryViewController *)source;
@end


@interface CharacterSkillsSummaryViewController : UIViewController <StatTableViewControllerDataSource>
@property (nonatomic, weak) id<CharacterSkillsSummaryViewControllerDataSource> dataSource;
@end
