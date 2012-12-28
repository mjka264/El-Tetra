//
//  CharacterLoadoutMetaViewController.m
//  El Tetra
//
//  Created by Matthew Kameron on 26/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterLoadoutViewController.h"
#import "CharacterLoadout.h"

@interface CharacterLoadoutViewController ()
- (void)refreshLoadout;
@end

@implementation CharacterLoadoutViewController
//@synthesize loadoutName = _loadoutName;
@synthesize characterLoadout = _characterLoadout;
- (void)setCharacterLoadout:(CharacterLoadout *)dataObject {
    _characterLoadout = dataObject;
    [self refreshLoadout];
}

- (void)refreshLoadout {
    self.characterLoadout.characterStats = [self.dataSource dataSourceCharacterStats];
    
    self.mainhandView.text = [self.characterLoadout mainhandName];
    self.offhandView.text = [self.characterLoadout offhandName];
    self.speedView.text = [[[self.characterLoadout derivedSpeed] valueForKey:@"description"] componentsJoinedByString:@": "];
    self.attackView.text = [[[self.characterLoadout derivedAttack] valueForKey:@"description"] componentsJoinedByString:@": "];
    self.damageView.text = [[[self.characterLoadout derivedDamage] valueForKey:@"description"] componentsJoinedByString:@": "];
    
    if ([[self.characterLoadout mainhandSpecials] count]) {
        self.weaponSpecialView.text = [[[self.characterLoadout mainhandSpecials] valueForKey:@"description"] componentsJoinedByString:@","];
    } else {
        self.weaponSpecialView.text = @" ";
    }
    
}

                           
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshLoadout];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
