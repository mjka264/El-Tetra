//
//  CharacterLoadout.h
//  El Tetra
//
//  Created by Matthew Kameron on 27/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface CharacterLoadout : NSObject
+ (CharacterLoadout *)defaultLoadout;
@property (nonatomic, strong) Item *mainhand;
@property (nonatomic, strong) Item *offhand;
@property (nonatomic, strong) Item *armour;
@property (nonatomic, strong) NSArray *gear;   // of Item
@end
