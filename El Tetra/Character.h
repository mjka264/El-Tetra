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
#import "CharacterStat.h"

@interface Character : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) CharacterStatPresenter *stats;
@property (nonatomic, strong) NSMutableArray *loadouts;     // of CharacterLoadout

// The dice pool is a NSArray of NSNumber.
// It is derived based on the Daoism stat of the character
- (NSArray *)getDicePool;
- (void)removeFromDicePool:(NSNumber *)dice;
- (void)resetDicePool;
@end
