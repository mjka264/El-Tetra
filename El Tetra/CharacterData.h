//
//  CharacterDataModel.h
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CHARACTER_SOUL_BODY @"Body"
#define CHARACTER_SOUL_MIND @"Mind"
#define CHARACTER_SOUL_SPIRIT @"Spirit"

#define CHARACTER_PRIMARY_FEROCITY @"Ferocity"
#define CHARACTER_PRIMARY_ACCURACY @"Accuracy"
#define CHARACTER_PRIMARY_AGILITY @"Agility"
#define CHARACTER_PRIMARY_RESILIENCE @"Resilience"
#define CHARACTER_PRIMARY_CHI @"Chi"

@interface CharacterData : NSObject
@property (nonatomic, strong) NSDictionary *soulStats;
@property (nonatomic, strong) NSDictionary *primaryStats;
@property (nonatomic, strong) NSDictionary *abilityStats;
+ (NSOrderedSet *)soulStatsPresentationOrder;
+ (NSOrderedSet *)primaryStatsPresentationOrder;
@end
