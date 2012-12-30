//
//  ColouredCircleWithNumberView.h
//  El Tetra
//
//  Created by Matthew Kameron on 24/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PrimaryStatColouredCircleView;

@protocol ColouredCircleAndHeaderDataSource <NSObject>
- (NSString *)textForHeading: (UIView *)source;
- (NSNumber *)fontSizeForHeading: (UIView *)source;
- (NSNumber *)numberForCircle:(UIView *)source;
- (NSInteger)elementForCircle:(UIView *)source;
- (NSNumber *)fontSizeForNumber:(UIView *)source;
@end

#define ELEMENT_FIRE @"Fire"
#define ELEMENT_AIR @"Air"
#define ELEMENT_WATER @"Water"
#define ELEMENT_EARTH @"Earth"
#define ELEMENT_CHI @"Chi"

@interface PrimaryStatColouredCircleView : UIView
@property (nonatomic, weak) id <ColouredCircleAndHeaderDataSource> dataSource;
@end
