//
//  ElTetraProtocols.h
//  El Tetra
//
//  Created by Matthew Kameron on 24/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StatTableViewHeaderDataSource <NSObject>
- (NSString *)textForHeading: (UIView *)source;
- (NSNumber *)fontSizeForHeading: (UIView *)source;
- (NSNumber *)numberForCircle:(UIView *)source;
- (NSString *)elementForCircle:(UIView *)source;
- (NSNumber *)fontSizeForNumber:(UIView *)source;
@end


@protocol StatTableViewControllerDataSource <NSObject>
// The data for the following line is a set of sets
// The outer set is the section
// The inner set is the stat within the section
- (NSOrderedSet *)dataForDisplay:(UIViewController *)statTVC;
@optional
- (NSString *)headingForDisplay:(UIViewController *)statTVC;
- (NSString *)elementForDisplay:(UIViewController *)statTVC;
- (NSString *)primaryStatValueForDisplay:(UIViewController *)statTVC;
@end