//
//  CharacterLoadoutEditorTableViewController.m
//  El Tetra
//
//  Created by Matthew Kameron on 28/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterLoadoutEditorViewController.h"
#import "Item.h"

@interface CharacterLoadoutEditorViewController ()

@end

@implementation CharacterLoadoutEditorViewController
@synthesize delegate = _delegate;
@synthesize loadout = _loadout;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[Item itemCategories] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger itemType = [[[Item itemCategories] objectAtIndex:section] integerValue];
    return [[Item allItemsWithType:itemType] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Loadout Item Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSInteger itemType = [[[Item itemCategories] objectAtIndex:indexPath.section] integerValue];
    Item *item = [[Item allItemsWithType:itemType] objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;
    
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
