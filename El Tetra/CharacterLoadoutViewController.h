//
//  CharacterLoadoutMetaViewController.h
//  El Tetra
//
//  Created by Matthew Kameron on 26/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterLoadout.h"

@protocol CharacterLoadoutViewControllerDataSource <NSObject>
- (id)dataSourceCharacterStats;
@end

@interface CharacterLoadoutViewController : UIViewController

// These fields are both set by the parent controller
@property (weak, nonatomic) CharacterLoadout *characterLoadout; 
@property (weak, nonatomic) id<CharacterLoadoutViewControllerDataSource> dataSource;

@property (nonatomic, weak) IBOutlet UILabel *mainhandView;
@property (nonatomic, weak) IBOutlet UILabel *offhandView;
@property (weak, nonatomic) IBOutlet UILabel *speedView;
@property (weak, nonatomic) IBOutlet UILabel *attackView;
@property (weak, nonatomic) IBOutlet UILabel *damageView;
@property (weak, nonatomic) IBOutlet UILabel *weaponSpecialView;

@property (weak, nonatomic) IBOutlet UILabel *armourView;
@property (weak, nonatomic) IBOutlet UILabel *basicDefenseView;
@property (weak, nonatomic) IBOutlet UILabel *specialDefenseView;
@property (weak, nonatomic) IBOutlet UILabel *magicDefenseView;
@property (weak, nonatomic) IBOutlet UILabel *soakView;
@property (weak, nonatomic) IBOutlet UILabel *armourSpecialView;

@property (weak, nonatomic) IBOutlet UILabel *gearView;
@property (weak, nonatomic) IBOutlet UILabel *gearSpecialView;
@end
