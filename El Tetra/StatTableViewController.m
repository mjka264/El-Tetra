//
//  StatTableViewController.m
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "StatTableViewController.h"
#import "PrimaryStatColouredCircleView.h"
#import "ElTetraDummyDelegate.h"

#pragma mark - StatTableViewControllerData

@implementation StatTableViewControllerData
@synthesize characterisic = _characterisic;
@synthesize value = _value;

+ (StatTableViewControllerData *)dataWithValue:(NSInteger)value forCharacteristic:(NSString *)characteristic
{
    StatTableViewControllerData *data = [[StatTableViewControllerData alloc] init];
    data.characterisic = characteristic;
    data.value = value;
    return data;
}
@end

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
@end



@implementation StatTableViewController
@synthesize dataSource = _dataSource;

#pragma mark - StatTableViewHeaderDataSource

- (NSString *)textForHeading: (UIView *)source {
    return [self.dataSource headingForDisplay:self];
}
- (NSNumber *)fontSizeForHeading: (UIView *)source {
    return [NSNumber numberWithInt:16];
}
- (NSNumber *)numberForCircle:(UIView *)source {
    return [NSNumber numberWithInt:16];
}
- (NSString *)elementForCircle:(UIView *)source {
    return [self.dataSource elementForDisplay:self];
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
    
    /* This code will allow for a normal heading in some cases.
    UIView *header;
    if ([self elementForCircle:self.view]) {
        header = [[StatTableViewHeader alloc] init];
        ((StatTableViewHeader *)header).dataSource = self;
        [header sizeToFit];
    } else {
        header = [[UILabel alloc] init];
        ((UILabel *)header).text = @"Moo";
        [header sizeToFit];
    }*/
    
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
    else return [[self.dataSource dataForDisplay:self] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionNumber
{
    NSOrderedSet *section = [[self.dataSource dataForDisplay:self]
                             objectAtIndex:sectionNumber];
    return [section count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatTableViewControllerData *data = [[[self.dataSource dataForDisplay:self]
                                          objectAtIndex:indexPath.section]
                                         objectAtIndex:indexPath.row];

    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Stat Cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[StatTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"Stat Cell"];
    }
    
    cell.textLabel.text = data.characterisic;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", data.value];
    return cell;
}

@end
