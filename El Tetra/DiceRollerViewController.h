//
//  DiceRollerViewController.h
//  El Tetra
//
//  Created by Matthew Kameron on 2/01/13.
//  Copyright (c) 2013 Matthew Kameron. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "CharacterStatPresenter.h"
#import "CharacterSelecterProtocol.h"

@class DiceRollerViewController;

@interface DiceRollerViewControllerDataSource : NSObject
- (CharacterStatPresenter *)dataSourceCharacterStatPresenter:(UIViewController *)source;
@end

@interface DiceRollerViewController : UIViewController
@property (nonatomic, weak) id<CharacterSelecterProtocol> dataSource;
@property (nonatomic, weak) IBOutlet UILabel *headingLabel;
- (void)initialiseWithDescription:(NSString *)headingForDisplayOrNil
                       dice:(NSInteger)numberOfDice
                   modifier:(NSInteger)modifierToRoll;
@end
