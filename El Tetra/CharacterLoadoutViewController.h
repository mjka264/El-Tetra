//
//  CharacterLoadoutMetaViewController.h
//  El Tetra
//
//  Created by Matthew Kameron on 26/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterLoadout.h"
#import "CharacterLoadoutEditorViewController.h"


@protocol CharacterLoadoutViewControllerDataSource <NSObject>
- (id)dataSourceCharacterStats;
@end

@interface CharacterLoadoutViewController : UIViewController <CharacterLoadoutEditorViewControllerDelegate>

// These fields are both set by the parent controller
@property (weak, nonatomic) CharacterLoadout *characterLoadout; 
@property (weak, nonatomic) id<CharacterLoadoutViewControllerDataSource> dataSource;

- (IBAction)newLoadoutPressed:(UIBarButtonItem *)sender;
- (IBAction)editLoadoutPressed:(UIBarButtonItem *)sender;
- (IBAction)trashLoadoutPressed:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UIToolbar *menuBarTrash;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuBarHeading;

@property (nonatomic, weak) IBOutlet UILabel *weaponsView;
@property (weak, nonatomic) IBOutlet UILabel *weaponSpecialsView;
@property (weak, nonatomic) IBOutlet UILabel *speedView;
@property (weak, nonatomic) IBOutlet UILabel *attackView;
@property (weak, nonatomic) IBOutlet UILabel *damageView;

@property (weak, nonatomic) IBOutlet UILabel *armourView;
@property (weak, nonatomic) IBOutlet UILabel *armourSpecialsView;

@property (weak, nonatomic) IBOutlet UILabel *basicDefenseView;
@property (weak, nonatomic) IBOutlet UILabel *blockDefenseTitleView;
@property (weak, nonatomic) IBOutlet UILabel *parryDefenseTitleView;
@property (weak, nonatomic) IBOutlet UILabel *blockDefenseValueView;
@property (weak, nonatomic) IBOutlet UILabel *parryDefenseValueView;

@property (weak, nonatomic) IBOutlet UILabel *magicDefenseView;
@property (weak, nonatomic) IBOutlet UILabel *soakView;

@property (weak, nonatomic) IBOutlet UILabel *gearView;
@property (weak, nonatomic) IBOutlet UILabel *gearSpecialView;
@end
