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
@property (nonatomic, weak) id<CharacterStatEditorTableViewCellDelegate> delegate;
- (void)stepperValueChanged;

@end
