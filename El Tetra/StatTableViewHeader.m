//
//  StatTableViewHeader.m
//  El Tetra
//
//  Created by Matthew Kameron on 24/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "StatTableViewHeader.h"
#import "ElTetraDummyDelegate.h"


@implementation StatTableViewHeader
@synthesize circleView = _circleView;
@synthesize headingLabel = _headingLabel;
@synthesize dataSource = _dataSource;
- (id <StatTableViewHeaderDataSource>) dataSource {
    if (!_dataSource) _dataSource = [[ElTetraDummyDelegate alloc] init];
    return _dataSource;
}

#define CIRCLE_RADIUS 35

- (UILabel *)headingLabel {
    if (!_headingLabel) {
        _headingLabel = [[UILabel alloc] init];
        _headingLabel.text = [self.dataSource textForHeading:self];
        _headingLabel.font = [UIFont boldSystemFontOfSize:[[self.dataSource fontSizeForHeading:self] integerValue]];
        _headingLabel.textAlignment = NSTextAlignmentCenter;
        _headingLabel.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    }
    return _headingLabel;
}

- (PrimaryStatColouredCircleView *)circleView {
    if (!_circleView) {
        _circleView = [[PrimaryStatColouredCircleView alloc] init];
        _circleView.dataSource = self.dataSource;
    }
    return _circleView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.headingLabel.frame = CGRectMake(0, 0, self.bounds.size.width - CIRCLE_RADIUS, self.bounds.size.height);
    self.circleView.frame = CGRectMake(self.bounds.size.width - CIRCLE_RADIUS, 0, CIRCLE_RADIUS, CIRCLE_RADIUS);
}

- (void)setupSelf {
    [self addSubview:self.headingLabel];
    [self addSubview:self.circleView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) [self setupSelf];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) [self setupSelf];
    return self;
}
- (CGSize)sizeThatFits:(CGSize)size
{
    NSInteger height = CIRCLE_RADIUS;         // ACTUALLY this should be the greater of the radius and the natural font height
    return CGSizeMake(height, CIRCLE_RADIUS);
}
@end
