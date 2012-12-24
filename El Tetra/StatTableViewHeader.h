//
//  StatTableViewHeader.h
//  El Tetra
//
//  Created by Matthew Kameron on 24/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrimaryStatColouredCircleView.h"

@class StatTableViewHeader;


@interface StatTableViewHeader : UIView
@property (nonatomic, strong) PrimaryStatColouredCircleView *circleView;
@property (nonatomic, weak) id <StatTableViewHeaderDataSource> dataSource;
@property (nonatomic, strong) UILabel *headingLabel;
@end

