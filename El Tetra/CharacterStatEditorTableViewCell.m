//
//  CharacterStatEditorTableViewCell.m
//  El Tetra
//
//  Created by Matthew Kameron on 30/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterStatEditorTableViewCell.h"

@implementation CharacterStatEditorTableViewCell
@synthesize delegate = _delegate;

- (void)stepperValueChanged {
    [self.delegate changeValueOfStatFromSender:self];
}

@end
