//
//  Character.m
//  El Tetra
//
//  Created by Matthew Kameron on 30/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "Character.h"

@interface Character ()
@property (strong, nonatomic)NSArray *dicePool;
@end

@implementation Character
@synthesize name = _name;
- (NSString *)name {
    if (!_name) _name = [NSString stringWithFormat:@"%d", arc4random()];
    return _name;
}

@synthesize stats = _stats;
- (CharacterStatPresenter *)stats {
    if (!_stats) _stats = [[CharacterStatPresenter alloc] init];
    return _stats;
}

@synthesize loadouts = _loadouts;
- (NSMutableArray *)loadouts {
    if (!_loadouts) _loadouts = [NSMutableArray arrayWithObject:[CharacterLoadout defaultLoadout]];
    return _loadouts;
}

@synthesize dicePool = _dicePool;
- (NSArray *)dicePool {
    if (!_dicePool) {
        NSMutableArray *newPool = [[NSMutableArray alloc] initWithCapacity:5];
        [newPool addObject:[NSNumber numberWithInteger:3]];
        [newPool addObject:[NSNumber numberWithInteger:3]];
        [newPool addObject:[NSNumber numberWithInteger:5]];
        [newPool addObject:[NSNumber numberWithInteger:7]];
        _dicePool = [newPool copy];
    }
    return _dicePool;
}
- (NSArray *)getDicePool {
    return self.dicePool;
}

- (void)removeFromDicePool:(NSNumber *)dice {
    NSMutableArray *newPool = [NSMutableArray arrayWithArray:self.dicePool];
    [newPool removeObjectAtIndex:[newPool indexOfObject:dice]];
    self.dicePool = [newPool copy];
}

- (void)resetDicePool {
    self.dicePool = nil;
}

@end
