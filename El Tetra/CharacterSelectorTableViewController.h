//
//  CharacterSelectorTableViewController.h
//  El Tetra
//
//  Created by Matthew Kameron on 30/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterCombatStatsViewController.h"
#import "CharacterStatEditorTableViewController.h"

@interface CharacterSelectorTableViewController : UITableViewController <CharacterSheetViewControllerDataSource, UITabBarControllerDelegate, CharacterStatEditorTableViewControllerDataSource>

@end
