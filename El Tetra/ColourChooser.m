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
    UIColor *returnValue;
    
    if (drawingContext == ColourChooserContextFill) {
        brightness = 1.0;
        saturation = 0.4;
    } else if (drawingContext == ColourChooserContextLine) {
        brightness = 0.4;
        saturation = 1.0;
    } else if (drawingContext == ColourChooserContextSubtleForeground) {
        brightness = 0.4;
        saturation = 1.0;
    } else if (drawingContext == ColourChooserContextSubtleBackground) {
        brightness = 0.9;
        saturation = 0.15;
    } else if (drawingContext == ColourChooserContextStrongForeground) {
        brightness = 0.8;
        saturation = 1.0;
    } else if (drawingContext == ColourChooserContextStrongBackground) {
        brightness = 0.4;
        saturation = 1.0;
    }
    
    // Helpers to assist with the special cases
    BOOL dualElement = characterStatElementIsDualElement(element);
    BOOL foreground = (drawingContext == ColourChooserContextLine ||
                       drawingContext == ColourChooserContextSubtleForeground ||
                       drawingContext == ColourChooserContextStrongForeground);
    if (dualElement) element = foreground ? characterStatGreekElement(element) : CharacterStatElementChi;

    // Now to work out the colour!    
    if (drawingContext == ColourChooserContextSubtleForeground && !dualElement) {
        returnValue = [UIColor blackColor];
    } else if (drawingContext == ColourChooserContextStrongForeground && !dualElement) {
        returnValue = [UIColor whiteColor];
    } else {
        if (element == CharacterStatElementChi) hue = 0.77;
        else if (element == CharacterStatElementFire) hue = 0.0;
        else if (element == CharacterStatElementAir) hue = 0.18;
        else if (element == CharacterStatElementWater) hue = 0.55;
        else if (element == CharacterStatElementEarth) hue = 0.33;
        else hue = 0.09;
    
        returnValue = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
    }
    
    return returnValue;
}

@end
