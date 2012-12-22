//
//  CharacterSheetCoreViewController.m
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterSheetCoreViewController.h"
#import "CharacterData.h"

@interface CharacterSheetCoreViewController ()
@property (nonatomic, strong) CharacterData *characterData;
@property (nonatomic, strong) NSMutableDictionary *embeddedStatViewControllers;
@end

@implementation CharacterSheetCoreViewController
@synthesize characterData = _characterData;
- (CharacterData *)characterData
{
    if (!_characterData) _characterData = [[CharacterData alloc] init];
    return _characterData;
}

@synthesize embeddedStatViewControllers = _embeddedStatViewControllers;
- (NSMutableDictionary *)embeddedStatViewControllers
{
    if (!_embeddedStatViewControllers) _embeddedStatViewControllers = [[NSMutableDictionary alloc] init];
    return _embeddedStatViewControllers;
}

- (NSString *)headingForDisplay:(StatTableViewController *)source
{
    NSString *heading;
    for (NSString* key in [self.embeddedStatViewControllers allKeys]) {
        if ([self.embeddedStatViewControllers valueForKey:key] == source) {
            heading = key;
        }
    }
    return heading;
}

- (NSOrderedSet *)dataForDisplay:(StatTableViewController *)source
{
    // check which source is being read
    NSDictionary *soul = [self.characterData soulStats];
    NSMutableOrderedSet *stats = [[NSMutableOrderedSet alloc] init];
    for (NSString *stat in [CharacterData soulStatsPresentationOrder]) {
        [stats addObject:[StatTableViewControllerData dataWithValue:[[soul valueForKey:stat] integerValue]
                                                  forCharacteristic:stat]];
    }
    NSOrderedSet *metaSet = [NSOrderedSet orderedSetWithObject:stats];
    return metaSet;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[StatTableViewController class]]) {
        if ([segue.identifier isEqualToString:EMBEDDED_VIEW_SOUL] ||
            [segue.identifier isEqualToString:EMBEDDED_VIEW_PRIMARY]) {
            StatTableViewController *destination = segue.destinationViewController;
            [self.embeddedStatViewControllers setObject:segue.destinationViewController
                                                     forKey:segue.identifier];
            destination.dataSource = self;
        }
    }
}

@end
