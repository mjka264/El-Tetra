//
//  CharacterSelectorTableViewController.m
//  El Tetra
//
//  Created by Matthew Kameron on 30/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "CharacterSelectorTableViewController.h"
#import "CharacterStatEditorViewController_TVC.h"
#import "Character.h"

@interface CharacterSelectorTableViewController ()
@property (nonatomic, strong) NSArray *allCharacters;
@property (nonatomic, weak) Character *characterSourceSelectedForViewing; // This is saved to help act as a data source
@end

@implementation CharacterSelectorTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

@synthesize allCharacters = _allCharacters;
- (NSArray *)allCharacters {
    if (!_allCharacters) {
        _allCharacters = @[
        [[Character alloc] init],
        [[Character alloc] init],
        [[Character alloc] init]];
    }
    return _allCharacters;
}

#pragma mark - Data source for my views that come from the tab controller

@synthesize characterSourceSelectedForViewing = _characterSourceSelectedForViewing;

- (Character *)dataSourceCharacter:(CharacterCombatStatsViewController *)source {
    return self.characterSourceSelectedForViewing;
}

- (CharacterStatPresenter *)dataSourceCharacterStatsPresenter:(UIViewController *)source {
    return self.characterSourceSelectedForViewing.stats;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return [self.allCharacters count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Big Button" forIndexPath:indexPath];
        cell.textLabel.text = @"New Character";
    } else {
        Character *character = [self.allCharacters objectAtIndex:indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:@"Character Sheet" forIndexPath:indexPath];
        cell.textLabel.text = character.name;
    }
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section > 0;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 0) {
        self.characterSourceSelectedForViewing = [self.allCharacters objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"Segue to Character" sender:self];
     }
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - UITabBarController view delegate

// This function is probably unnecessary since the dataSources are all set in the prepareForSegue.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [viewController performSelector:@selector(setDataSource:) withObject:self];
    [viewController.view setNeedsDisplay];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *destination = segue.destinationViewController;
        destination.delegate = self;
        [destination.viewControllers enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL *stop) {
            [obj performSelector:@selector(setDataSource:) withObject:self];
        }];
    }
}

@end
