//
//  CharacterSheetCoreViewController.h
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatViewController.h"

@interface CharacterSheetCoreViewController : UIViewController <StatTableViewControllerDataSource>
- (NSOrderedSet *)dataForStatTVC:(StatViewController *)source;
@end
