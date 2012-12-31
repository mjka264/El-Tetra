//
//  ColourChooser.m
//  El Tetra
//
//  Created by Matthew Kameron on 31/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "ColourChooser.h"

@implementation ColourChooser
+ (UIColor *)getUIColorForElement:(t_CharacterStatElement)element
                        inContext:(t_ColourChooserContext)drawingContext {
    CGFloat hue, saturation, brightness;
    
    if (drawingContext == ColourChooserContextFill) {
        brightness = 1.0;
        saturation = 0.4;
    } else if (drawingContext == ColourChooserContextLine) {
        brightness = 0.4;
        saturation = 1.0;
    } else if (drawingContext == ColourChooserContextSolid) {
        brightness = 0.4;
        saturation = 1.0;
    } else if (drawingContext == ColourChooserContextSubtleBackground) {
        brightness = 0.9;
        saturation = 0.15;
    }

    BOOL foreground = (drawingContext == ColourChooserContextLine ||
                       drawingContext == ColourChooserContextSolid);
    
    if (element == CharacterStatElementFire ||
        (element == CharacterStatElementFireChi && foreground)) hue = 0.0;
    else if (element == CharacterStatElementAir ||
             (element == CharacterStatElementAirChi && foreground)) hue = 0.18;
    else if (element == CharacterStatElementWater ||
             (element == CharacterStatElementWaterChi && foreground)) hue = 0.55;
    else if (element == CharacterStatElementEarth ||
             (element == CharacterStatElementEarthChi && foreground)) hue = 0.33;
    else if (element == CharacterStatElementChi ||
             (!foreground && (element == CharacterStatElementFireChi ||
                              element == CharacterStatElementAirChi ||
                              element == CharacterStatElementWaterChi ||
                              element == CharacterStatElementEarthChi))) hue = 0.77;
    else hue = 0.09;

    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
}

@end
