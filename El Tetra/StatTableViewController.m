//
//  StatTableViewController.m
//  El Tetra
//
//  Created by Matthew Kameron on 22/12/12.
//  Copyright (c) 2012 Matthew Kameron. All rights reserved.
//

#import "StatTableViewController.h"


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
@interface StatTableViewCell : UITableViewCell; @end
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

#pragma mark - StatTableViewHeader

@interface StatTableViewHeader : UIView
@property (nonatomic, strong) UIView *circleBit;
@property (nonatomic, strong) UILabel *textBit;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *element;
@property (nonatomic, strong) NSString *colour;
@end
@implementation StatTableViewHeader
@synthesize circleBit = _circleBit;
@synthesize textBit = _textBit;
- (UILabel *)textBit {
    if (!_textBit) {
        _textBit = [[UILabel alloc] init];
        _textBit.text = @"Moo"; // self.title;
        _textBit.font = [UIFont boldSystemFontOfSize:16];
        _textBit.textAlignment = NSTextAlignmentCenter;
        _textBit.backgroundColor = [UIColor clearColor];
    }
    return _textBit;
}
@synthesize title = _title;
@synthesize element = _element;
@synthesize colour = _colour;

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textBit.frame = CGRectMake(0, 0, 20, 30);
    //[self.textBit sizeToFit];
    //self.tableView.tableHeaderView = label;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.textBit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addSubview:self.textBit];
    }
    return self;
}

@end



#pragma mark - StatTableViewController

@interface StatTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation StatTableViewController
@synthesize dataSource = _dataSource;
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
    header.title = @"Ferocity";
    header.element = @"Fire";
    header.colour = @"red";
    self.tableView.tableHeaderView = header;
    
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
    return [[self.dataSource dataForDisplay:self] count];
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
    
    cell.textLabel.text = data.characterisic;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", data.value];
    return cell;
}

@end
