//
//  DiceRollerViewController.m
//  El Tetra
//
//  Created by Matthew Kameron on 2/01/13.
//  Copyright (c) 2013 Matthew Kameron. All rights reserved.
//

#import "DiceRollerViewController.h"
#import "Character.h"

@interface DiceRollerViewController ()
@property (nonatomic, readonly) Character *diceData;
@end

@implementation DiceRollerViewController
@synthesize dataSource = _dataSource;
- (Character *)diceData {
    return [self.dataSource dataSourceCharacter:self];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
