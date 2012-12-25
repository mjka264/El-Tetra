//
//  CharacterSheetCoreViewController.h
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatTableViewController.h"
#import "CharacterData.h"

@interface CharacterSheetSkillsViewController : UIViewController <StatTableViewControllerDataSource>
//- (NSOrderedSet *)dataForDisplay:(StatTableViewController *)source;
@end




#define SUBVIEW_TAG_SOUL 0
#define SUBVIEW_TAG_FIRE 1
#define SUBVIEW_TAG_AIR 2
#define SUBVIEW_TAG_WATER 3
#define SUBVIEW_TAG_EARTH 4
#define SUBVIEW_TAG_CHI 5