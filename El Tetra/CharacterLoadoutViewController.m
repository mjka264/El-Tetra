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
    // Link the data sources together
    self.characterLoadout.characterStats = [self.dataSource dataSourceCharacterStats];
    
    // Setup the special attibute tags to put with the NSAttributedStrings
    NSDictionary *headingAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIFont boldSystemFontOfSize:14], NSFontAttributeName,
                                       [UIColor blackColor], NSForegroundColorAttributeName, nil];
    NSDictionary *grayAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont systemFontOfSize:10], NSFontAttributeName,
                                    [UIColor grayColor], NSForegroundColorAttributeName, nil];
    NSDictionary *orangeAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [UIFont boldSystemFontOfSize:10], NSFontAttributeName,
                                      [UIColor orangeColor], NSForegroundColorAttributeName, nil];
    NSDictionary *blueAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont systemFontOfSize:10], NSFontAttributeName,
                                    [UIColor blueColor], NSForegroundColorAttributeName, nil];

    // weaponView
    NSMutableAttributedString *weapons = [[NSMutableAttributedString alloc]
                                          initWithString:[self.characterLoadout mainhandName]
                                          attributes:headingAttributes];
    NSString *offhand = [self.characterLoadout offhandName];
    if (offhand) {
        [weapons appendAttributedString:[[NSAttributedString alloc]
                                         initWithString:[@" and " stringByAppendingString:offhand]
                                         attributes:grayAttributes]];
    }
    NSString *weaponSpecials = [[[self.characterLoadout mainhandSpecials] valueForKey:@"description"] componentsJoinedByString:@", "];
    if (weaponSpecials) {
        [weapons appendAttributedString:[[NSAttributedString alloc]
                                         initWithString:[@"  " stringByAppendingString:weaponSpecials]
                                         attributes:orangeAttributes]];
    }
    
    /*
    
    NSString *mainhand = ;
    NSString *offhand = ;
    
    if (offhand) {
        offhand = [@" and " stringByAppendingString:offhand];
    }
    if (weaponSpecials) weaponSpecials = [@"  " stringByAppendingString:weaponSpecials];
    */
    
    //if (offhand) {
        
    //}
    
    //if ([[self.characterLoadout mainhandSpecials] count]) {
    //    self.weaponSpecialView.text = [[[self.characterLoadout mainhandSpecials] valueForKey:@"description"] componentsJoinedByString:@","];
    //} else {
    //    self.weaponSpecialView.text = @" ";
    //}
    /*
    NSMutableAttributedString *weapons = [[NSMutableAttributedString alloc]
                                          initWithString:[NSString stringWithFormat:@"%@%@%@", mainhand, offhand, weaponSpecials]];
    if (offhand) [weapons setAttributes:grayAttributes range:NSMakeRange([mainhand length], [offhand length])];
    if (weaponSpecials) [weapons setAttributes:orangeAttributes range:NSMakeRange([mainhand length] + [offhand length], [weaponSpecials length])];
    */
    /*
    


       [weapons set]
        //weapons = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ and %@", mainhand, offhand]
        //                                                 attributes:headingAttributes];
        [weapons setAttributes:grayAttributes range:NSMakeRange([mainhand length], [[weapons string] length] - [mainhand length])];
    } else {
        weapons = [[NSMutableAttributedString alloc] initWithString:mainhand
                                                         attributes:headingAttributes];
    }
     */
    [self.weaponView setAttributedText:weapons];
    
    

    
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
