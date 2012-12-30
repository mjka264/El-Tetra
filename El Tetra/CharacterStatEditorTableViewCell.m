//
//  CharacterStatEditorTableViewCell.m
//  El Tetra
//
//  Created by Matthew Kameron on 30/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterStatEditorTableViewCell.h"

@implementation CharacterStatEditorTableViewCell

/*
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
 */

@synthesize delegate = _delegate;
- (void)stepperValueChanged {
    [self.delegate changeValueOfStatFromSender:self];
}


@end
