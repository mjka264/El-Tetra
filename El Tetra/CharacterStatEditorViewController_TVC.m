//
//  CharacterStatEditorTableViewController.m
//  El Tetra
//
//  Created by Matthew Kameron on 30/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterStatEditorViewController_TVC.h"
#import "CharacterStatEditorTableViewCell.h"
#import "ColourChooser.h"

@interface CharacterStatEditorViewController_TVC ()
@property (readonly, nonatomic) CharacterStatPresenter *characterStats;
@end

@implementation CharacterStatEditorViewController_TVC

@synthesize dataSource = _dataSource;
- (CharacterStatPresenter *)characterStats {
    return [self.dataSource dataSourceCharacterStatsPresenter:self];
}

#pragma mark - CharacterStatEditorTableViewCellDelegate

- (void)changeValueOfStatFromSender:(CharacterStatEditorTableViewCell *)source {
    [self.characterStats setStatWithDescription:source.descriptionView.text
                                          value:source.stepperView.value];
    [self updateContentOfViews];
}

- (void)updateContentOfViews {
    [self.tableView reloadData];
    self.characterStatsSummaryView.text = [NSString stringWithFormat:@"Total points spent: %d", [self.characterStats totalStatCost]];
}

- (void)viewDidLoad {
    [self updateContentOfViews];
    self.characterStatsSummaryView.backgroundColor = [ColourChooser getUIColorForElement:CharacterStatElementNone
                                                                               inContext:ColourChooserContextStrongBackground];
    self.characterStatsSummaryView.textColor = [ColourChooser getUIColorForElement:CharacterStatElementNone
                                                                               inContext:ColourChooserContextStrongForeground];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.characterStats getEditableStatsInGroups] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"%@", self.characterStats.allStats);
    //NSLog(@"%d", [[[self.characterStats getEditableStatsInGroups] objectAtIndex:section] count]);
    
    return [[[self.characterStats getEditableStatsInGroups] objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CharacterStat *stat = [[[self.characterStats getEditableStatsInGroups] objectAtIndex:section] lastObject];
    
    //NSLog(@"%@", [CharacterStatPresenter headingForGroup:stat.groupMembership]);
    
    return [CharacterStatPresenter headingForGroup:stat.groupMembership];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = ((CharacterStatEditorTableViewCell *)cell).targetBackgroundColour;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CharacterStatEditorTableViewCell *cell = (CharacterStatEditorTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"MyEditCell"];
    CharacterStat *stat = [[[self.characterStats getEditableStatsInGroups] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
    // Initialise straight forward content
    cell.descriptionView.text = stat.statName;
    if (stat.value) cell.valueView.text = [NSString stringWithFormat:@"%d", stat.value];
    else cell.valueView.text = @"";
    cell.targetBackgroundColour = [ColourChooser getUIColorForElement:stat.elementMembership inContext:ColourChooserContextSubtleBackground];
    cell.descriptionView.textColor = [ColourChooser getUIColorForElement:stat.elementMembership inContext:ColourChooserContextSubtleForeground];
    
    // Setup the highlight colors
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [ColourChooser getUIColorForElement:stat.elementMembership inContext:ColourChooserContextBrightBackground];
    cell.selectedBackgroundView = selectionColor;
    cell.valueView.highlightedTextColor = [ColourChooser getUIColorForElement:stat.elementMembership inContext:ColourChooserContextBrightForeground];
    cell.descriptionView.highlightedTextColor = [ColourChooser getUIColorForElement:stat.elementMembership inContext:ColourChooserContextBrightForeground];
    
    // Initialise the stepper callbacks
    cell.delegate = self;
    [cell.stepperView addTarget:cell action:@selector(stepperValueChanged) forControlEvents:UIControlEventValueChanged];
    cell.stepperView.minimumValue = stat.minimumValue;
    cell.stepperView.maximumValue = stat.maximumValue;
    cell.stepperView.value = stat.value;
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"Nib name" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
