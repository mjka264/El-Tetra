


#import <Foundation/Foundation.h>


@interface CharacterStat : NSObject  // CharacterStat does *not* support copying - otherwise the links get mucked up
@property (nonatomic, strong) NSString *statName;
@property (nonatomic) NSInteger value;

// These 3 fields provide all the information required to identify the stat
@property (nonatomic) NSInteger groupMembership;     // one of the enum CharacterStatGroup
@property (nonatomic) NSInteger elementMembership;   // one of the enum CharacterStatElement
@property (nonatomic) NSInteger soulMembership;      // CharacterStatSpecialNot for most things
@property (nonatomic, readonly) NSInteger skillCost;      // derived based upon group memberships
@property (nonatomic, readonly) NSInteger minimumValue;   // 1 for primary/soul/skills, 0 for abilities

#define STAT_ARTFUL @"Artful weapons"
#define STAT_BRUTAL @"Brutal weapons"
#define STAT_PROJECTILE @"Projectile weapons"
#define STAT_INITIATIVE @"Initiative"

+ (NSArray *)newCharacterStatsSet;

@end
