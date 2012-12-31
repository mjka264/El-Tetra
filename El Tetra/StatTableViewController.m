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
@property (nonatomic, readonly) NSInteger element;

@end



@implementation StatTableViewController

@synthesize dataSource = _dataSource;
- (CharacterStatPresenter *)characterStats {
    return [self.dataSource characterStatsFrom:self];
}

#pragma mark - StatTableViewHeaderDataSource

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    for (UIView *view in self.view.subviews) {
        [view setNeedsDisplay];
    }
}

- (NSInteger)element {
    CharacterStat *stat;
    if (self.characterStats.headingStat) {
        stat = self.characterStats.headingStat;
    } else {
        stat = [self.characterStats.allStats lastObject];
    }
    return stat.elementMembership;
}
- (NSString *)textForHeading: (UIView *)source {
    return self.characterStats.headingStat.statName;
}
- (NSNumber *)fontSizeForHeading: (UIView *)source {
    return [NSNumber numberWithInt:16];
}
- (NSNumber *)numberForCircle:(UIView *)source {
    return [NSNumber numberWithInteger:self.characterStats.headingStat.value];
}
- (NSInteger)elementForCircle:(UIView *)source {
    return self.element;
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
    
    if (self.characterStats.headingStat) {
        StatTableViewHeader *header = [[StatTableViewHeader alloc] init];
        header.dataSource = self;
        [header sizeToFit];
        [self.view addSubview:header];
        self.tableView.tableHeaderView = header;
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionNumber
{
    return [self.characterStats.allStats count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Stat Cell" forIndexPath:indexPath];
    CharacterStat *stat;
    
    stat = [self.characterStats.allStats objectAtIndex:indexPath.row];
    
    cell.textLabel.text = stat.statName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", stat.value];
    return cell;
}

@end
