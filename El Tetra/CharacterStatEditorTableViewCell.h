//
//  CharacterStatEditorTableViewCell.h
//  El Tetra
//
//  Created by Matthew Kameron on 30/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CharacterStatEditorTableViewCell;

@protocol CharacterStatEditorTableViewCellDelegate <NSObject>
- (void)changeValueOfStatFromSender:(CharacterStatEditorTableViewCell *)source;
@end

@interface CharacterStatEditorTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIStepper *stepperView;
@property (weak, nonatomic) IBOutlet UILabel *valueView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionView;
@property (nonatomic, weak) id<CharacterStatEditorTableViewCellDelegate> delegate;

// For some reason you cannot set the background colour in the delegate's cellForRowAtIndexPath
// so instead I am setting it in the delegate's willDisplayCell:forCellAtIndexPath
@property (nonatomic, strong) UIColor *targetBackgroundColour;
- (void)stepperValueChanged;
@end
