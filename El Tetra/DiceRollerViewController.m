//
//  DiceRollerViewController.m
//  El Tetra
/*
 This file needs to have:
 (1) A data source for the purpose of tracking and editing the dice pool
 (2) To be initialised with a number of dice and a modifier for its calculation
 */

#import "DiceRollerViewController.h"
#import "Character.h"

@interface DiceRollerViewController ()

@property (nonatomic, readonly) Character *diceData;
@property (nonatomic) NSInteger numberOfDice;
@property (nonatomic) NSInteger diceModifier;
@property (nonatomic) NSString *headingForDisplay;
@end

@implementation DiceRollerViewController
@synthesize dataSource = _dataSource;
- (Character *)dicePool {
    return [self.dataSource dataSourceCharacter:self];
}
@synthesize numberOfDice = _numberOfDice;
@synthesize diceModifier = _diceModifier;
@synthesize headingForDisplay = _headingForDisplay;

- (void)initialiseWithDescription:(NSString *)headingForDisplayOrNil
                             dice:(NSInteger)numberOfDice
                         modifier:(NSInteger)modifierToRoll {
    self.headingForDisplay = headingForDisplayOrNil;
    self.numberOfDice = numberOfDice;
    self.diceModifier = modifierToRoll;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 100, 100)];
    [self.view addSubview:label];
    label.text = [[self.diceData getDicePool] componentsJoinedByString:@","];
    
    self.headingLabel.text = self.headingForDisplay;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
