//
//  Character.h
//  El Tetra
//
//  Created by Matthew Kameron on 30/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CharacterStatPresenter.h"
#import "CharacterLoadout.h"

@interface Character : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) CharacterStatPresenter *stats;
@property (nonatomic, strong) NSMutableArray *loadouts;     // of CharacterLoadout
@end
