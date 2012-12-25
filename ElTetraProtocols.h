//
//  ElTetraProtocols.h
//  El Tetra
//
//  Created by Matthew Kameron on 24/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StatTableViewHeaderDataSource <NSObject>
- (NSString *)textForHeading: (UIView *)source;
- (NSNumber *)fontSizeForHeading: (UIView *)source;
- (NSNumber *)numberForCircle:(UIView *)source;
- (NSInteger)elementForCircle:(UIView *)source;
- (NSNumber *)fontSizeForNumber:(UIView *)source;
@end


// This id is something that CharacterData can process
@protocol StatTableViewControllerDataSource <NSObject>
- (id)characterData:(UIViewController *)source;
@end


// BUG: There is ineffeciency as easch time a StatTableViewController gets data from the CharacterSheetViewController, it is regenerated rather than being looked up from a cache.

// BUG: CharacterData.copyWithZone should really be using staticly defined variables (ie globals) for its easy dictionaries rather than creating them again and again. Temporarily, I dropped the readonly attribute to achieve a similar thing.