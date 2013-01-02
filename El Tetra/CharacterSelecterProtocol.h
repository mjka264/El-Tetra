//
//  CharacterSelecterProtocol.h
//  El Tetra
//
//  Created by Matthew Kameron on 2/01/13.
//  Copyright (c) 2013 Matthew Kameron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CharacterStatPresenter.h"
#import "Character.h"

@protocol CharacterSelecterProtocol <NSObject>

- (Character *)dataSourceCharacter:(UIViewController *)source;
- (CharacterStatPresenter *)dataSourceCharacterStatsPresenter:(UIViewController *)source;

@end
