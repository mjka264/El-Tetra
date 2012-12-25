//
//  CharacterSheetAbilitiesViewController.h
//  El Tetra
//
//  Created by Matthew Kameron on 25/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterSheetSkillsViewController.h"

@interface CharacterSheetAbilitiesViewController : CharacterSheetSkillsViewController
@property (nonatomic, weak) IBOutlet UILabel *soulStatBody;
@property (nonatomic, weak) IBOutlet UILabel *soulStatMind;
@property (nonatomic, weak) IBOutlet UILabel *soulStatSpirit;
@end
