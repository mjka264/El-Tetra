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
@property (nonatomic, strong) NSString *statValue;
- (UIColor *)getColourOfElement:(BOOL)darkerVersion;
@end
@implementation StatTableViewHeader
@synthesize circleBit = _circleBit;
@synthesize statValue = _statValue;
@synthesize textBit = _textBit;
- (UILabel *)textBit {
    if (!_textBit) {
        _textBit = [[UILabel alloc] init];
        _textBit.text = self.title;
        _textBit.font = [UIFont boldSystemFontOfSize:16];
        _textBit.textAlignment = NSTextAlignmentCenter;
        _textBit.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    }
    return _textBit;
}
@synthesize title = _title;
- (void)setTitle:(NSString *)title {
    _title = title;
    self.textBit.text = _title;
}
@synthesize element = _element;

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textBit.frame = CGRectMake(0, 0, 80, 25);
    //[self.textBit sizeToFit];
    //self.tableView.tableHeaderView = label;
}
- (UIColor *)getColourOfElement:(BOOL)darkerVersion {
    CGFloat brightness = darkerVersion? 0.5 : 1.0;
    CGFloat saturation = darkerVersion? 1.0 : 0.4;
    CGFloat hue;
    if ([self.element isEqualToString:@"Fire"]) hue = 0.0;
    else if ([self.element isEqualToString:@"Air"]) hue = 0.18;
    else if ([self.element isEqualToString:@"Water"]) hue = 0.55;
    else if ([self.element isEqualToString:@"Earth"]) hue = 0.33;
        
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
}

- (void)drawRect:(CGRect)rect {
    if (self.statValue) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        // Make the background white
        CGContextSetRGBFillColor(context, 1,1,1, 1);
        CGContextFillRect(context, rect);
        
        // Draw the outside of the circle
        [[self getColourOfElement:YES] setStroke];
        //CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
        CGContextSetLineWidth(context, 2);
        CGContextBeginPath(context);
        CGContextAddArc(context, rect.size.width - rect.size.height/2,
                        rect.size.height/2, rect.size.height/2 - 1, 0, 2*M_PI, YES);
        CGContextStrokePath(context);
        
        // Fill the middle of the circle
        //CGContextSetRGBFillColor(context, 0, 1, 0, 1);
        [[self getColourOfElement:NO] setFill];
        CGContextBeginPath(context);
        CGContextAddArc(context, rect.size.width - rect.size.height/2,
                        rect.size.height/2, rect.size.height/2 - 2, 0, 2*M_PI, YES);
        CGContextFillPath(context);
        
        // Write a number in the middle of the circle
        CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
        CGAffineTransform transform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0);
        CGContextSetTextMatrix(context, transform);
        CGContextSelectFont(context, "Helvetica", 18.0, kCGEncodingMacRoman);
        CGContextSetTextDrawingMode(context, kCGTextFill);
        const char *statValue = [self.statValue UTF8String];
        CGContextShowTextAtPoint(context, rect.size.width - rect.size.height/2 -5, rect.size.height/2 +5, statValue, 1);
    }
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
- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(70,25);
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
    header.title = [self.dataSource headingForDisplay:self];
    header.element = [self.dataSource elementForDisplay:self];
    header.statValue = [self.dataSource primaryStatValueForDisplay:self];
    [header sizeToFit];
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
