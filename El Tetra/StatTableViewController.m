//
//  StatTableViewController.m
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "StatTableViewController.h"
#import "PrimaryStatColouredCircleView.h"
#import "CharacterStatPresenter.h"


#pragma mark - StatTableViewCell
@interface StatTableViewCell : UITableViewCell;
@end

@implementation StatTableViewCell



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Either font size 12: 1 line, or size 8: 1 line, or size 8: 2 lines.
    CGSize sizeWith12 = [self.textLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:12]
                                        constrainedToSize:CGSizeMake(self.textLabel.frame.size.width, 1000)
                                            lineBreakMode:NSLineBreakByWordWrapping];
    CGSize sizeWith8  = [self.textLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:8]
                                        constrainedToSize:CGSizeMake(self.textLabel.frame.size.width, 1000)
                                            lineBreakMode:NSLineBreakByWordWrapping];
    if (sizeWith12.height <= 25) { // 25 was trial and error
        self.textLabel.font = [UIFont boldSystemFontOfSize:12];
        self.textLabel.numberOfLines = 1;
    } else if (sizeWith8.height <= 20) { // 20 was trial and error
        self.textLabel.font = [UIFont boldSystemFontOfSize:8];
        self.textLabel.numberOfLines = 1;
    } else {
        self.textLabel.font = [UIFont boldSystemFontOfSize:6];
        self.textLabel.numberOfLines = 2;
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
}
@end





#pragma mark - StatTableViewController

@interface StatTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic, readonly) CharacterStatPresenter *characterStats;
@end



@implementation StatTableViewController

@synthesize dataSource = _dataSource;
- (CharacterStatPresenter *)characterStats {
    return [self.dataSource characterStatsFrom:self];
}

#pragma mark - StatTableViewHeaderDataSource



- (NSString *)textForHeading: (UIView *)source {
    return [CharacterStatPresenter sectionHeadingFrom:[self.dataSource characterStats:self]];
    //return [self.dataSource headingForDisplay:self];
}
- (NSNumber *)fontSizeForHeading: (UIView *)source {
    return [NSNumber numberWithInt:16];
}
- (NSNumber *)numberForCircle:(UIView *)source {
    return [CharacterStatPresenter ];
    //return [NSNumber numberWithInt:3];
}
- (NSInteger)elementForCircle:(UIView *)source {
    return [CharacterStatPresenter statElementforHeadingFrom:[self.dataSource characterStats:self]];
    //return [self.dataSource elementForDisplay:self];
}
- (NSNumber *)fontSizeForNumber:(UIView *)source {
    return [NSNumber numberWithInt:16];
}




- (UITableView *)tableView {
    if (!_tableView) _tableView = (UITableView *) self.view;
    return _tableView;
}

@synthesize tableView = _tableView;

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
    
    StatTableViewHeader *header = [[StatTableViewHeader alloc] init];
    header.dataSource = self;
    [header sizeToFit];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = header;

    // The next line of code didn't work because it always instantiated my class with default style
    // So I couldn't save the left detail style. I would have had to reimplement the subviews.
    //[self.tableView registerClass:[StatTableViewCell class] forCellReuseIdentifier:@"Stat Cell"];
}

#pragma mark - Table view data source

@synthesize hideTableData = _hideTableData;
- (void)setHideTableData:(BOOL)hideTableData {
    if (hideTableData != _hideTableData) {
        _hideTableData = hideTableData;
        [self.tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hideTableData) return 0;
    else return [CharacterStatPresenter numberOfStatGroupsFrom:[self.dataSource characterStats:self]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionNumber
{
    return [CharacterStatPresenter numberOfEntriesFrom:[self.dataSource characterStats:self]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Stat Cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[StatTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"Stat Cell"];
    }
    
    cell.textLabel.text = [CharacterStatPresenter statDescriptionFrom:[self.dataSource characterStats:self] atIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [CharacterStatPresenter statValueFrom:[self.dataSource characterStats:self] atIndex:indexPath.row]];
    
    return cell;
}

@end
