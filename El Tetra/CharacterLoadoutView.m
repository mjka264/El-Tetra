//
//  CharacterLoadoutView.m
//  El Tetra
//
//  Created by Matthew Kameron on 28/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterLoadoutView.h"

@implementation CharacterLoadoutView
@synthesize blockHidden = _blockHidden;
@synthesize parryHidden = _parryHidden;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

// This is the code that manages moving labels up and down
#define LABEL_BLOCK 1
#define LABEL_PARRY 2
#define LABEL_MAGIC 3
#define HEIGHT_DIFFERENCE 20

- (void)layoutSubviews {
    [super layoutSubviews];
    UIView *subview;
    for (subview in self.subviews) {
        if (subview.tag == LABEL_PARRY) {
            if (self.blockHidden) {
                subview.frame = CGRectMake(subview.frame.origin.x, subview.frame.origin.y - HEIGHT_DIFFERENCE,
                                           subview.frame.size.width, subview.frame.size.height);
            }
        } else if (subview.tag == LABEL_MAGIC) {
            if (self.blockHidden && self.parryHidden) {
                subview.frame = CGRectMake(subview.frame.origin.x, subview.frame.origin.y - 2 * HEIGHT_DIFFERENCE,
                                           subview.frame.size.width, subview.frame.size.height);
            }
            else if (self.blockHidden || self.parryHidden) {
                subview.frame = CGRectMake(subview.frame.origin.x, subview.frame.origin.y - HEIGHT_DIFFERENCE,
                                           subview.frame.size.width, subview.frame.size.height);
            }
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
