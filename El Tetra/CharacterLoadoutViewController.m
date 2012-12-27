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
- (void)refreshDataObject;
@end

@implementation CharacterLoadoutViewController
//@synthesize loadoutName = _loadoutName;
@synthesize dataObject = _dataObject;
- (void)setDataObject:(CharacterLoadout *)dataObject {
    _dataObject = dataObject;
    [self refreshDataObject];
}

- (void)refreshDataObject {
    self.mainhandView.text = self.dataObject.mainhand.name;
    self.offhandView.text = self.dataObject.offhand.name;
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
    [self refreshDataObject];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
