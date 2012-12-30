//
//  ColouredCircleWithNumberView.m
//  El Tetra
//
//  Created by Matthew Kameron on 24/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "PrimaryStatColouredCircleView.h"
#import "CharacterStatPresenter.h"

@implementation PrimaryStatColouredCircleView

- (UIColor *)getColourForCircle:(BOOL)perimeterColour {
    CGFloat brightness = perimeterColour? 0.5 : 1.0;
    CGFloat saturation = perimeterColour? 1.0 : 0.4;
    CGFloat hue;
    
    NSInteger element = [self.dataSource elementForCircle:self];

    if (element == CharacterStatElementFire) hue = 0.0;
    else if (element == CharacterStatElementAir) hue = 0.18;
    else if (element == CharacterStatElementWater) hue = 0.55;
    else if (element == CharacterStatElementEarth) hue = 0.33;
    else if (element == CharacterStatElementChi) hue = 0.77;
    else hue = 0.09;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
}
    
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

    }
    return self;
}
- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(300,300);
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint centre = CGPointMake(rect.size.width/2, rect.size.height/2);
    CGFloat radius = rect.size.height < rect.size.width ? rect.size.height/2 : rect.size.width/2;
    
    // Make the background white
    CGContextSetRGBFillColor(context, 1,1,1, 1);
    CGContextFillRect(context, rect);

    // Draw the outside of the circle
    [[self getColourForCircle:YES] setStroke];
    CGContextSetLineWidth(context, 2);
    CGContextBeginPath(context);
    CGContextAddArc(context, centre.x, centre.y, radius-1, 0, 2*M_PI, YES);
    CGContextStrokePath(context);
    
    // Fill the middle of the circle
    [[self getColourForCircle:NO] setFill];
    CGContextBeginPath(context);
    CGContextAddArc(context, centre.x, centre.y, radius-1, 0, 2*M_PI, YES);
    CGContextFillPath(context);
    
    // Write a number in the middle of the circle
    const char *statText = [[NSString stringWithFormat:@"%@", [self.dataSource numberForCircle:self]] UTF8String];
    NSInteger fontSize = [[self.dataSource fontSizeForNumber:self] integerValue];
    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
    CGAffineTransform transform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0);
    CGContextSetTextMatrix(context, transform);
    CGContextSelectFont(context, "Helvetica", fontSize, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGSize sizeOfText = [[NSString stringWithCString:statText encoding:NSASCIIStringEncoding] sizeWithFont:[UIFont fontWithName:@"Helvetica" size:fontSize]];
    CGContextShowTextAtPoint(context, centre.x-sizeOfText.width/2, centre.y+sizeOfText.height/4, statText, 1);
}


@end
