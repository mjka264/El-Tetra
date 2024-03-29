//
//  StatTableViewHeader.m
//  El Tetra
//
//  Created by Matthew Kameron on 24/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "StatTableViewHeader.h"




@implementation StatTableViewHeader
@synthesize circleView = _circleView;
@synthesize headingLabel = _headingLabel;
@synthesize dataSource = _dataSource;



#define CIRCLE_RADIUS 35

- (void)setDataSource:(id<ColouredCircleAndHeaderDataSource>) newSource {
    if (_dataSource != newSource) {
        _dataSource = newSource;
        [self setupSelf];
    }
}


- (UILabel *)headingLabel {
    if (!_headingLabel) {
        _headingLabel = [[UILabel alloc] init];
        _headingLabel.textAlignment = NSTextAlignmentCenter;
        _headingLabel.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    }
    return _headingLabel;
}

- (PrimaryStatColouredCircleView *)circleView {
    if ([self.dataSource elementForCircle:self]) {
        if (!_circleView) {
            _circleView = [[PrimaryStatColouredCircleView alloc] init];
            _circleView.dataSource = (id<ColouredCircleAndHeaderDataSource>) self.dataSource;
        }
    } else {
        _circleView = nil;
    }
    return _circleView;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.circleView) {
        self.headingLabel.frame = CGRectMake(0, 0, self.bounds.size.width - CIRCLE_RADIUS, self.bounds.size.height);
        self.circleView.frame = CGRectMake(self.bounds.size.width - CIRCLE_RADIUS, 0, CIRCLE_RADIUS, CIRCLE_RADIUS);
    } else {
        self.headingLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    }
}

- (void)drawRect:(CGRect)rect {
    [self.circleView setNeedsDisplay];
}

- (void)setupSelf {
    [self addSubview:self.headingLabel];
    [self addSubview:self.circleView];
    self.headingLabel.text = [self.dataSource textForHeading:self];
    self.headingLabel.font = [UIFont boldSystemFontOfSize:[[self.dataSource fontSizeForHeading:self] integerValue]];
    self.circleView.dataSource = self.dataSource;
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
