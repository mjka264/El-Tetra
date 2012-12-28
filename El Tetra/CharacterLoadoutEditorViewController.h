//
//  CharacterLoadoutEditorTableViewController.h
//  El Tetra
//
//  Created by Matthew Kameron on 28/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterLoadout.h"
#import "Item.h"

@class CharacterLoadoutEditorViewController;

@protocol CharacterLoadoutEditorViewControllerDelegate <NSObject>
/*
- (BOOL)tableViewController:(CharacterLoadoutEditorViewController *)controller
shouldAllowSelectionForCellAtIndexPath:(Indexpath *)Indexpath
usingCharacterLoadout:
*/
- (void)dismissMePlease;
@end

@interface CharacterLoadoutEditorViewController : UITableViewController
- (IBAction)unloadCharacterLoadoutViewController:(id)sender;
@property (nonatomic, weak) id<CharacterLoadoutEditorViewControllerDelegate> delegate;
@property (nonatomic, weak) CharacterLoadout *loadout;
@end
