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

@end

@implementation CharacterLoadoutViewController
@synthesize loadoutName = _loadoutName;
@synthesize dataObject = _dataObject;
- (void)setDataObject:(CharacterLoadout *)dataObject {
    _dataObject = dataObject;
    self.loadoutName.text = _dataObject;
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
    self.loadoutName.text = [self.dataObject weaponDescriptorMainhand];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
