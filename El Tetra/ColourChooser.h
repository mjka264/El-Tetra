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
    ColourChooserContextLine = 1,
    ColourChooserContextFill = 2,
    ColourChooserContextSubtleBackground = 3,
    ColourChooserContextSolid = 4
} t_ColourChooserContext;

@interface ColourChooser : NSObject
+ (UIColor *)getUIColorForElement:(t_CharacterStatElement)element
                        inContext:(t_ColourChooserContext)whatYouAreTryingToDraw;
@end
