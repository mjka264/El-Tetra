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

/*
- (NSAttributedString *)generateAttributedStringWithFirstPart:(NSString *)firstPart
                                                   Attributes:(NSDictionary *)firstAttributes
                                                   secondPart:(NSString *)secondPart
                                                   Attributes:(NSDictionary *)secondAttributes;
*/
- (NSAttributedString *)generateModifedStatLabel:(NSString *)label
                                      attributes:(NSDictionary *)labelAttributes
                                            dice:(NSNumber *)dice
                                      attributes:(NSDictionary *)diceAttributes
                                        modifier:(NSNumber *)modifier
                                      attributes:(NSDictionary *)modifierAttributes;
- (NSDictionary *)makeAttributesSize:(NSInteger)fontSize
                                bold:(BOOL)bold
                              colour:(UIColor *)colour;
@end

@implementation CharacterLoadoutViewController
//@synthesize loadoutName = _loadoutName;
@synthesize characterLoadout = _characterLoadout;
- (void)setCharacterLoadout:(CharacterLoadout *)dataObject {
    _characterLoadout = dataObject;
    [self refreshLoadout];
}

- (NSAttributedString *)generateModifedStatLabel:(NSString *)label
                                      attributes:(NSDictionary *)labelAttributes
                                            dice:(NSNumber *)dice
                                      attributes:(NSDictionary *)diceAttributes
                                        modifier:(NSNumber *)modifier
                                      attributes:(NSDictionary *)modifierAttributes {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]
                                         initWithString:label attributes:labelAttributes];
    if (dice) [string appendAttributedString:[[NSMutableAttributedString alloc]
                                    initWithString:[NSString stringWithFormat:@" %@", dice] attributes:diceAttributes]];
    if ([modifier integerValue]) [string appendAttributedString:[[NSMutableAttributedString alloc]
                                                      initWithString:[NSString stringWithFormat:@" + %@", modifier] attributes:modifierAttributes]];
    return string;
}

- (NSAttributedString *)generateModifedStatDice:(NSNumber *)dice
                                      attributes:(NSDictionary *)diceAttributes
                                        modifier:(NSNumber *)modifier
                                      attributes:(NSDictionary *)modifierAttributes {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    if (dice) [string appendAttributedString:[[NSMutableAttributedString alloc]
                                              initWithString:[NSString stringWithFormat:@" %@", dice] attributes:diceAttributes]];
    if ([modifier integerValue]) [string appendAttributedString:[[NSMutableAttributedString alloc]
                                                                 initWithString:[NSString stringWithFormat:@" + %@", modifier] attributes:modifierAttributes]];
    return string;
}

- (NSDictionary *)makeAttributesSize:(NSInteger)fontSize
                                bold:(BOOL)bold
                              colour:(UIColor *)colour {
    NSShadow *shadow;
    if (colour == [UIColor yellowColor]) {
        shadow = [[NSShadow alloc] init];
        shadow.shadowColor = [UIColor yellowColor];
        shadow.shadowOffset = CGSizeMake(2, 2);
        colour = [UIColor blackColor];
    }
    if (shadow)
        if (bold)
            return [NSDictionary dictionaryWithObjectsAndKeys:
                    [UIFont boldSystemFontOfSize:fontSize], NSFontAttributeName,
                    shadow, NSShadowAttributeName,
                    colour, NSForegroundColorAttributeName, nil];
        else
            return [NSDictionary dictionaryWithObjectsAndKeys:
                    [UIFont systemFontOfSize:fontSize], NSFontAttributeName,
                    shadow, NSShadowAttributeName,
                    colour, NSForegroundColorAttributeName, nil];
    else
        if (bold)
            return [NSDictionary dictionaryWithObjectsAndKeys:
                    [UIFont boldSystemFontOfSize:fontSize], NSFontAttributeName,
                    colour, NSForegroundColorAttributeName, nil];
        else
            return [NSDictionary dictionaryWithObjectsAndKeys:
                    [UIFont systemFontOfSize:fontSize], NSFontAttributeName,
                    colour, NSForegroundColorAttributeName, nil];
}

- (void)refreshLoadout {
    // Link the data sources together
    self.characterLoadout.characterStats = [self.dataSource dataSourceCharacterStats];

    // Weapon names
    NSString *weaponSpecials = [[[self.characterLoadout mainhandSpecials] valueForKey:@"description"] componentsJoinedByString:@", "];
    if (!weaponSpecials) {
        self.mainhandView.text = [self.characterLoadout mainhandName];
    } else {
        NSMutableAttributedString *weapons = [[NSMutableAttributedString alloc]
                                              initWithString:[self.characterLoadout mainhandName]
                                              attributes:[self makeAttributesSize:14 bold:YES colour:[UIColor blackColor]]];
        [weapons appendAttributedString:[[NSAttributedString alloc]
                                         initWithString:[@"  " stringByAppendingString:weaponSpecials]
                                         attributes:[self makeAttributesSize:10 bold:NO colour:[UIColor orangeColor]]]];
        self.mainhandView.attributedText = weapons;
    }
    self.offhandView.text = [self.characterLoadout offhandName]? [@"and " stringByAppendingString:[self.characterLoadout offhandName]]:@"";
    
    // Armour name
    NSString *armourSpecials = [[[self.characterLoadout armourSpecials] valueForKey:@"description"] componentsJoinedByString:@", "];
    if (!armourSpecials) {
        self.armourView.text = [self.characterLoadout armourName];
    } else {
        NSMutableAttributedString *armour = [[NSMutableAttributedString alloc]
                                             initWithString:armourSpecials
                                             attributes:[self makeAttributesSize:10 bold:NO colour:[UIColor orangeColor]]];
        [armour appendAttributedString: [[NSAttributedString alloc]
                                         initWithString:[@"  " stringByAppendingString:[self.characterLoadout armourName]]
                                         attributes:[self makeAttributesSize:14 bold:YES colour:[UIColor blackColor]]]];
        self.armourView.attributedText = armour;
    }
    
    // Other offensive stats
    self.attackView.attributedText = [self generateModifedStatDice:[self.characterLoadout derivedAttack:YES]
                                                         attributes:[self makeAttributesSize:14 bold:YES colour:[UIColor yellowColor]]
                                                           modifier:[self.characterLoadout derivedAttack:NO]
                                                         attributes:[self makeAttributesSize:10 bold:NO colour:[UIColor blackColor]]];
    
    self.speedView.attributedText = [self generateModifedStatDice:[self.characterLoadout derivedSpeed:YES]
                                                        attributes:[self makeAttributesSize:14 bold:YES colour:[UIColor blueColor]]
                                                           modifier:[self.characterLoadout derivedSpeed:NO]
                                                        attributes:[self makeAttributesSize:10 bold:NO colour:[UIColor blackColor]]];

    self.damageView.attributedText = [self generateModifedStatDice:[self.characterLoadout derivedDamage:YES]
                                                        attributes:[self makeAttributesSize:14 bold:YES colour:[UIColor redColor]]
                                                          modifier:[self.characterLoadout derivedDamage:NO]
                                                        attributes:[self makeAttributesSize:10 bold:NO colour:[UIColor blackColor]]];
    
    // Defensive stats
    self.basicDefenseView.text = [[self.characterLoadout derivedBasicDefense] description];
    self.magicDefenseView.text = [[self.characterLoadout derivedMagicDefense] description];
    self.soakView.text = [[self.characterLoadout derivedSoak] description];
    
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
