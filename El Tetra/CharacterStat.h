


#import <Foundation/Foundation.h>
#import "CharacterStatPresenter.h"



@interface CharacterStat : NSObject
@property (nonatomic, strong) NSString *description;
@property (nonatomic) NSInteger value;

#define STAT_ARTFUL @"Artful weapons"
#define STAT_BRUTAL @"Brutal weapons"
#define STAT_PROJECTILE @"Projectile weapons"
#define STAT_INITIATIVE @"Initiative"

// These 3 fields provide all the information required to identify the stat
@property (nonatomic) t_CharacterStatGroup groupMembership;     // one of the enum CharacterStatGroup
@property (nonatomic) t_CharacterStatElement elementMembership;   // one of the enum CharacterStatElement
@property (nonatomic) t_CharacterStatSoulLink soulMembership;   // CharacterStatSpecialNot for most things

+ (NSArray *)characterStatsSetCopy;

@end
