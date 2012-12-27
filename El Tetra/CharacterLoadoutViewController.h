//
//  CharacterLoadoutMetaViewController.h
//  El Tetra
//
//  Created by Matthew Kameron on 26/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharacterLoadout.h"

@interface CharacterLoadoutViewController : UIViewController
@property (nonatomic, weak) IBOutlet UILabel *mainhandView;
@property (nonatomic, weak) IBOutlet UILabel *offhandView;

@property (weak, nonatomic) CharacterLoadout *dataObject;
@end
