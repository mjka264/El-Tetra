//
//  ColouredCircleWithNumberView.h
//  El Tetra
//
//  Created by Matthew Kameron on 24/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ElTetraProtocols.h"

@class PrimaryStatColouredCircleView;

#define ELEMENT_FIRE @"Fire"
#define ELEMENT_AIR @"Air"
#define ELEMENT_WATER @"Water"
#define ELEMENT_EARTH @"Earth"
#define ELEMENT_CHI @"Chi"

@interface PrimaryStatColouredCircleView : UIView
@property (nonatomic, weak) id <StatTableViewHeaderDataSource> dataSource;
@end
