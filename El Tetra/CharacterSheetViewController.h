//
//  CharacterSheetCoreViewController.h
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatTableViewController.h"
#import "CharacterStatPresenter.h"
#import "CharacterLoadoutViewController.h"
#import "Character.h"

@class CharacterSheetViewController;

@protocol CharacterSheetViewControllerDataSource <NSObject>
- (Character *)characterData:(CharacterSheetViewController *)source;
@end

@interface CharacterSheetViewController : UIViewController
<StatTableViewControllerDataSource, UIPageViewControllerDataSource, CharacterLoadoutViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, weak) UIPageViewController *pageViewController;
@property (nonatomic, weak) id<CharacterSheetViewControllerDataSource> dataSource;
           
@property (nonatomic, weak) IBOutlet UILabel *soulStatBody;
@property (nonatomic, weak) IBOutlet UILabel *soulStatMind;
@property (nonatomic, weak) IBOutlet UILabel *soulStatSpirit;
@end


/*

#define SUBVIEW_TAG_SOUL 0
#define SUBVIEW_TAG_FIRE 1
#define SUBVIEW_TAG_AIR 2
#define SUBVIEW_TAG_WATER 3
#define SUBVIEW_TAG_EARTH 4
#define SUBVIEW_TAG_CHI 5
*/