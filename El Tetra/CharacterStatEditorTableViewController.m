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
@end

@implementation CharacterStatEditorTableViewController
@synthesize dataSource = _dataSource;
- (CharacterStats *)characterStats {
    return [self.dataSource characterStatData:self];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[CharacterStats editableStatGroupsFrom:self.characterStats] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    t_CharacterStatGroup group = [[[CharacterStats editableStatGroupsFrom:self.characterStats] objectAtIndex:section] integerValue];
    return [CharacterStats numberOfEntriesFrom:self.characterStats inStatGroup:group];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *CellIdentifier = @"EditableStat";
    //CharacterStatEditorTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //BOOL isMyCell = [cell isKindOfClass:[CharacterStatEditorTableViewCell class]];
    
    //cell.statNameView.text = @"Happy";
    //cell.statValueView.text = @"3";
     */
    
    CharacterStatEditorTableViewCell *cell = (CharacterStatEditorTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"MyEditCell"];
    
    // Initialise straight forward content
    t_CharacterStatGroup group = [[[CharacterStats editableStatGroupsFrom:self.characterStats] objectAtIndex:indexPath.section] integerValue];
    cell.descriptionView.text = [CharacterStats statDescriptionFrom:self.characterStats
                                                       atIndex:indexPath.row
                                                   inStatGroup:group];
    NSNumber *value = [CharacterStats statValueFrom:self.characterStats
                                            atIndex:indexPath.row
                                        inStatGroup:group];
    cell.valueView.text = [value description];
    
    // Initialise the stepper callbacks
    cell.delegate = self;
    cell.dataToLinkToSpecificStat = indexPath;
    [cell.stepperView addTarget:cell action:@selector(stepperValueChanged) forControlEvents:UIControlEventValueChanged];
    cell.stepperView.value = [value doubleValue];
                       
    return cell;
}

- (void)changeValueOfStatFromSender:(CharacterStatEditorTableViewCell *)source {
    NSIndexPath *path = source.dataToLinkToSpecificStat;
    NSNumber *value = [NSNumber numberWithDouble:source.stepperView.value];
    t_CharacterStatGroup group = [[[CharacterStats editableStatGroupsFrom:self.characterStats] objectAtIndex:path.section] integerValue];
    [CharacterStats setStatValueFrom:self.characterStats atIndex:path.row inStatGroup:group to:[value integerValue]];
    source.valueView.text = [value description];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
