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
@property (readonly, nonatomic) CharacterStats *characterStats;
- (t_CharacterStatGroup)statGroupFromSectionNumber:(NSInteger)section;
@end

@implementation CharacterStatEditorTableViewController
@synthesize dataSource = _dataSource;
- (CharacterStats *)characterStats {
    return [self.dataSource characterStatData:self];
}

- (t_CharacterStatGroup)statGroupFromSectionNumber:(NSInteger)section; {
    return [[[CharacterStats editableStatGroupsFrom:self.characterStats] objectAtIndex:section] integerValue];
}

#pragma mark - CharacterStatEditorTableViewCellDelegate

- (void)changeValueOfStatFromSender:(CharacterStatEditorTableViewCell *)source {
    NSIndexPath *path = source.dataToLinkToSpecificStat;
    NSNumber *value = [NSNumber numberWithDouble:source.stepperView.value];
    [CharacterStats setStatValueFrom:self.characterStats atIndex:path.row
                         inStatGroup:[self statGroupFromSectionNumber:path.section]
                                  to:[value integerValue]];
    source.valueView.text = [value description];
    
    
    NSLog(@"Cost=%d", [CharacterStats statCostFor:self.characterStats]);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[CharacterStats editableStatGroupsFrom:self.characterStats] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [CharacterStats numberOfEntriesFrom:self.characterStats
                                   inStatGroup:[self statGroupFromSectionNumber:section]];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [CharacterStats sectionHeadingFrom:self.characterStats inStatGroup:[self statGroupFromSectionNumber:section]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CharacterStatEditorTableViewCell *cell = (CharacterStatEditorTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"MyEditCell"];
    
    // Initialise straight forward content
    cell.descriptionView.text = [CharacterStats statDescriptionFrom:self.characterStats
                                                       atIndex:indexPath.row
                                                   inStatGroup:[self statGroupFromSectionNumber:indexPath.section]];
    NSNumber *value = [CharacterStats statValueFrom:self.characterStats
                                            atIndex:indexPath.row
                                        inStatGroup:[self statGroupFromSectionNumber:indexPath.section]];
    cell.valueView.text = [value description];
    
    // Initialise the stepper callbacks
    cell.delegate = self;
    cell.dataToLinkToSpecificStat = indexPath;
    [cell.stepperView addTarget:cell action:@selector(stepperValueChanged) forControlEvents:UIControlEventValueChanged];
    cell.stepperView.value = [value doubleValue];
    cell.stepperView.minimumValue = [self statGroupFromSectionNumber:indexPath.section] == CharacterStatGroupAbilities? 0 : 1;

    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
