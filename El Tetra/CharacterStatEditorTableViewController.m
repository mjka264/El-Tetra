//
//  CharacterStatEditorTableViewController.m
//  El Tetra
//
//  Created by Matthew Kameron on 30/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterStatEditorTableViewController.h"
#import "CharacterStatEditorTableViewCell.h"

@interface CharacterStatEditorTableViewController ()
@property (readonly, nonatomic) CharacterStatPresenter *characterStats;
@end

@implementation CharacterStatEditorTableViewController
@synthesize dataSource = _dataSource;
- (CharacterStatPresenter *)characterStats {
    return [self.dataSource characterStatData:self];
}

#pragma mark - CharacterStatEditorTableViewCellDelegate

- (void)changeValueOfStatFromSender:(CharacterStatEditorTableViewCell *)source {
    [self.characterStats setStatWithDescription:source.descriptionView.text
                                          value:source.stepperView.value];
    [self.tableView reloadData];
    //source.valueView.text = [NSString stringWithFormat:@"%d", (NSInteger) source.stepperView.value];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CharacterStatEditorTableViewCell *cell = (CharacterStatEditorTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"MyEditCell"];
    CharacterStat *stat = [[[self.characterStats getEditableStatsInGroups] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    //NSLog(@"Creating at %@, %@", indexPath, stat.description);
    
    // Initialise straight forward content
    cell.descriptionView.text = stat.statName;
    cell.valueView.text = [NSString stringWithFormat:@"%d", stat.value];
    
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
