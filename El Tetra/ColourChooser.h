//
//  ColourChooser.h
//  El Tetra
//
//  Created by Matthew Kameron on 31/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CharacterStatPresenter.h"

typedef enum {
    ColourChooserContextLine,
    ColourChooserContextFill,
    ColourChooserContextSubtleBackground,
    ColourChooserContextSubtleForeground,
    ColourChooserContextStrongBackground,
    ColourChooserContextStrongForeground
} t_ColourChooserContext;

@interface ColourChooser : NSObject
+ (UIColor *)getUIColorForElement:(t_CharacterStatElement)element
                        inContext:(t_ColourChooserContext)whatYouAreTryingToDraw;
@end
