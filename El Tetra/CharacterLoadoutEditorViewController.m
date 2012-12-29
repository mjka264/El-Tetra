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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSInteger itemType = [[[Item itemCategories] objectAtIndex:section] integerValue];
    if (itemType == ItemTypeWeaponDualhand) return @"Two-handed weapons";
    else if (itemType == ItemTypeWeaponMainhand) return @"Mainhand weapons";
    else if (itemType == ItemTypeWeaponOffhand) return @"Offhand weapons";
    else if (itemType == ItemTypeArmour) return @"Armour";
    else if (itemType == ItemTypeGear) return @"Gear";
    else return @"";
}

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
    cell.detailTextLabel.text = [item itemPropertiesSummaryForTableView];
    
    if ([self.loadout isEquippingItem:item]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger itemType = [[[Item itemCategories] objectAtIndex:indexPath.section] integerValue];
    Item *item = [[Item allItemsWithType:itemType] objectAtIndex:indexPath.row];
    
    [self.loadout equipItem:item];
    [[self tableView] reloadData];
    
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)unloadCharacterLoadoutViewController:(id)sender {
    [self.delegate dismissMePlease];
}
@end
