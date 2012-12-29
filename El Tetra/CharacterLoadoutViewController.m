//
//  CharacterLoadoutMetaViewController.m
//  El Tetra
//
//  Created by Matthew Kameron on 26/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterLoadoutViewController.h"
#import "CharacterLoadoutView.h"

@interface CharacterLoadoutViewController ()
- (void)refreshLoadout;

- (NSAttributedString *)generateModifedStatDice:(NSNumber *)dice
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


- (NSAttributedString *)generateModifedStatDice:(NSNumber *)dice
                                      attributes:(NSDictionary *)diceAttributes
                                        modifier:(NSNumber *)modifier
                                      attributes:(NSDictionary *)modifierAttributes {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    if (dice) [string appendAttributedString:[[NSMutableAttributedString alloc]
                                              initWithString:[NSString stringWithFormat:@" %@", dice] attributes:diceAttributes]];
    NSString *operator = [modifier integerValue] > 0? @"+":@"-";
    if ([modifier integerValue] < 0) modifier = [NSNumber numberWithInteger:-[modifier integerValue]];
    if ([modifier integerValue]) {
        [string appendAttributedString:[[NSMutableAttributedString alloc]
                                        initWithString:[NSString stringWithFormat:@" %@ %@", operator, modifier]
                                        attributes:modifierAttributes]];
    }
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

    // Header stuff
    self.menuBarHeading.title = self.characterLoadout.name;
    
    // Weapon (mainhand and offhand)
    if (![self.characterLoadout offhandName]) {
        self.weaponsView.text = [self.characterLoadout mainhandName];
    } else {
        NSMutableAttributedString *weapons = [[NSMutableAttributedString alloc]
                                              initWithString:[self.characterLoadout mainhandName]
                                              attributes:[self makeAttributesSize:14 bold:YES colour:[UIColor blackColor]]];
        [weapons appendAttributedString:[[NSAttributedString alloc]
                                         initWithString:[@"  and " stringByAppendingString:[self.characterLoadout offhandName]]
                                         attributes:[self makeAttributesSize:10 bold:NO colour:[UIColor grayColor]]]];
        self.weaponsView.attributedText = weapons;
    }
    //self.offhandView.text = [self.characterLoadout offhandName]? [@"and " stringByAppendingString:[self.characterLoadout offhandName]]:@"";
    
    // Weapon specials and armour
    self.weaponSpecialsView.text = [[[self.characterLoadout mainhandSpecials] valueForKey:@"description"] componentsJoinedByString:@", "];
    self.armourView.text = [self.characterLoadout armourName];
    self.armourSpecialsView.text = [[[self.characterLoadout armourSpecials] valueForKey:@"description"] componentsJoinedByString:@", "];

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
    if ([self.characterLoadout derivedBlockDefense]) {
        self.blockDefenseTitleView.text = @"Block";
        self.blockDefenseValueView.text = [[self.characterLoadout derivedBlockDefense] description];
        ((CharacterLoadoutView *)self.view).blockHidden = NO;
    } else {
        self.blockDefenseTitleView.text = @"";
        self.blockDefenseValueView.text = @"";
        ((CharacterLoadoutView *)self.view).blockHidden = YES;
    }
    if ([self.characterLoadout derivedParryDefense]) {
        self.parryDefenseTitleView.text = @"Parry";
        self.parryDefenseValueView.text = [[self.characterLoadout derivedParryDefense] description];
        ((CharacterLoadoutView *)self.view).parryHidden = NO;
    } else {
        self.parryDefenseTitleView.text = @"";
        self.parryDefenseValueView.text = @"";
        ((CharacterLoadoutView *)self.view).parryHidden = YES;
        
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[CharacterLoadoutEditorViewController class]]) {
        CharacterLoadoutEditorViewController *destination = segue.destinationViewController;
        destination.delegate = self;
        destination.loadout = self.characterLoadout;
    }
}

#pragma mark -
#pragma mark CharacterLoadoutEditorViewController Delegate

- (void)dismissMePlease {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)newLoadoutPressed:(UIBarButtonItem *)sender {
}

- (IBAction)editLoadoutPressed:(UIBarButtonItem *)sender {
}

- (IBAction)trashLoadoutPressed:(UIBarButtonItem *)sender {
}
@end
