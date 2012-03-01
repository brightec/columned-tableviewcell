//
//  ViewController.m
//  columned-tableview
//
//  Created by Cameron Cooke on 27/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ColumedTableViewCell.h"
#import "ColumnedHeaderFooterView.h"

@implementation ViewController
@synthesize tableView = _tableView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editClicked)];
    self.navigationItem.rightBarButtonItem = editButton;
    [editButton release];  
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    _columnWidths = [NSArray arrayWithObjects:
                     [NSNumber numberWithInt:150], 
                     [NSNumber numberWithInt:50], 
                     [NSNumber numberWithInt:50], 
                     [NSNumber numberWithInt:50], nil];
    
    static int margin = 9.0;
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40.0)];
    self.tableView.tableHeaderView = tableHeaderView;
    [tableHeaderView release];        
    
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame = CGRectMake(margin, margin, self.tableView.tableHeaderView.bounds.size.width-margin*2, 0);
    progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth;    
    [progressView setProgress:0.7 animated:NO];
    [self.tableView.tableHeaderView addSubview:progressView];
    
    UILabel *progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(progressView.frame), CGRectGetWidth(progressView.frame), 20.0)];
    progressLabel.opaque = NO;
    progressLabel.backgroundColor = [UIColor clearColor];
    progressLabel.text = @"You are 70% of the way through your budgetting period.";
    progressLabel.textColor = [UIColor whiteColor];
    progressLabel.font = [UIFont boldSystemFontOfSize:10.0];
    progressLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    progressLabel.shadowOffset = CGSizeMake(0, -1);    
    progressLabel.textAlignment = UITextAlignmentCenter;
    progressLabel.adjustsFontSizeToFitWidth = YES;
    progressLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.tableView.tableHeaderView addSubview:progressLabel];
    [progressLabel release];
    
    [progressView release];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"MyCell";
    
    ColumedTableViewCell *cell = (ColumedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[ColumedTableViewCell alloc] initWithColumnWidths: _columnWidths reuseIdentifier:cellId] autorelease];
        cell.flexibleFirstColumn = YES;
        
        // create line label
        UIView *lineContentView = [cell cellContentViewForColumnIndex:0];
        UILabel *lineLabel = [ViewController createCellLabel];
        lineLabel.frame = CGRectMake(0, 0, lineContentView.bounds.size.width, lineContentView.bounds.size.height);
        [lineContentView addSubview:lineLabel];
        
        // create budget label
        UIView *budgetContentView = [cell cellContentViewForColumnIndex:1];
        UILabel *budgetLabel = [ViewController createCellLabel];
        budgetLabel.frame = CGRectMake(0, 0, budgetContentView.bounds.size.width, budgetContentView.bounds.size.height);
        [budgetContentView addSubview:budgetLabel];   
        
        // create actual label
        UIView *actualContentView = [cell cellContentViewForColumnIndex:2];
        UILabel *actualLabel = [ViewController createCellLabel];
        actualLabel.frame = CGRectMake(0, 0, actualContentView.bounds.size.width, actualContentView.bounds.size.height);
        [actualContentView addSubview:actualLabel];         
        
        // create status traffic light
        UIView *statusContentView = [cell cellContentViewForColumnIndex:3];
        UIImageView *light = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red.png"]];
        light.center = CGPointMake(20, 22);
        [statusContentView addSubview:light];
        [light release];
    }
    
    // set label text
    UIView *lineContentView = [cell cellContentViewForColumnIndex:0];
    UILabel *lineLabel = (UILabel *)[lineContentView.subviews objectAtIndex:0];
    lineLabel.text = @"Gas bill";

    UIView *budgetContentView = [cell cellContentViewForColumnIndex:1];
    UILabel *budgetLabel = (UILabel *)[budgetContentView.subviews objectAtIndex:0];    
    budgetLabel.text = @"£155";
    
    UIView *actualContentView = [cell cellContentViewForColumnIndex:2];
    UILabel *actualLabel = (UILabel *)[actualContentView.subviews objectAtIndex:0];    
    actualLabel.text = @"£123";
    
    UIView *statusContentView = [cell cellContentViewForColumnIndex:3];    
    UIImageView *light = (UIImageView *)[statusContentView.subviews objectAtIndex:0];    
    
    if (indexPath.row == 2) {
        light.image = [UIImage imageNamed:@"green.png"];
    }
    else if(indexPath.row == 1) {
        light.image = [UIImage imageNamed:@"amber.png"];        
    }
    
    // tell cell what position it is
    int numberOfRowsInCurrentSection = [self.tableView numberOfRowsInSection:indexPath.section];
    if(indexPath.row == 0 && numberOfRowsInCurrentSection == 1) {
        cell.position = ColumedTableViewCellPositionTopBottom;
    }
    else if(indexPath.row == 0) {
        cell.position = ColumedTableViewCellPositionTop;
    }
    else if(indexPath.row == numberOfRowsInCurrentSection-1) {
        cell.position = ColumedTableViewCellPositionBottom;
    }
    else {
        cell.position = ColumedTableViewCellPositionMiddle;
    }

//    if(cell.position == ColumedTableViewCellPositionTop) {
//        cell.contentView.backgroundColor = [UIColor redColor];
//    }
//    else if(cell.position == ColumedTableViewCellPositionBottom) {
//        cell.contentView.backgroundColor = [UIColor blueColor];
//    }
//    else if(cell.position == ColumedTableViewCellPositionMiddle) {
//        cell.contentView.backgroundColor = [UIColor yellowColor];
//    }        
//    else if(cell.position == ColumedTableViewCellPositionTopBottom) {
//        cell.contentView.backgroundColor = [UIColor purpleColor];
//    }      
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }     
    
    return 49;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    
    ColumnedHeaderFooterView *header = [[[ColumnedHeaderFooterView alloc] initWithColumnWidths:_columnWidths frame:CGRectMake(0, 0, 320, [self tableView:tableView heightForHeaderInSection:section]) sectionType:ColumnedSectionTypeHeader] autorelease];
    header.flexibleFirstColumn = YES;
    
    if (section == 1) {
        header.lightColour = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:44.0/255.0 alpha:1.0];
        header.darkColour = [UIColor colorWithRed:255.0/255.0 green:142.0/255.0 blue:7.0/255.0 alpha:1.0];
    }
    else  if(section == 2) {
        header.lightColour = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
        header.darkColour = [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0];        
    }
    
    // set column headers
    UIFont *font = [UIFont boldSystemFontOfSize:16.0f];
    UIFont *smallFont = [UIFont boldSystemFontOfSize:12.0f];
    
    UILabel *column1Label = [header labelForColumnIndex:0];
    column1Label.text = @"Expenditure";
    column1Label.font = font;
    
    UILabel *column2Label = [header labelForColumnIndex:1];
    column2Label.text = @"Budget";
    column2Label.font = smallFont;
    
    UILabel *column3Label = [header labelForColumnIndex:2];
    column3Label.text = @"Actual";
    column3Label.font = smallFont;
    
    UILabel *column4Label = [header labelForColumnIndex:3];
    column4Label.text = @"Status";   
    column4Label.font = smallFont;
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{
    if (section == 0) {
        return 0;
    } 
    
    return 49;
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }    
    
    ColumnedHeaderFooterView *footer = [[[ColumnedHeaderFooterView alloc] initWithColumnWidths:_columnWidths frame:CGRectMake(0, 0, 320, [self tableView:tableView heightForFooterInSection:section]) sectionType:ColumnedSectionTypeFooter] autorelease];
    footer.flexibleFirstColumn = YES;
    
    footer.lightColour = [UIColor colorWithRed:188.0/255.0 green:188.0/255.0 blue:188.0/255.0 alpha:1.0];
    footer.darkColour = [UIColor colorWithRed:118.0/255.0 green:118.0/255.0 blue:118.0/255.0 alpha:1.0];
    
    // set column headers
    UIFont *font = [UIFont boldSystemFontOfSize:16.0f];
    UIFont *smallFont = [UIFont boldSystemFontOfSize:12.0f];
    
    UILabel *column1Label = [footer labelForColumnIndex:0];
    column1Label.text = @"Total";
    column1Label.font = font;
    
    UILabel *column2Label = [footer labelForColumnIndex:1];
    column2Label.text = @"";
    column2Label.font = smallFont;
    
    UILabel *column3Label = [footer labelForColumnIndex:2];
    column3Label.text = @"";
    column3Label.font = smallFont;
    
    UILabel *column4Label = [footer labelForColumnIndex:3];
    column4Label.text = @"";   
    column4Label.font = smallFont;
    
    return footer;    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)editClicked
{
    BOOL editing = !self.tableView.isEditing;
    BOOL animated = YES;
    
    [super setEditing:editing animated:animated];  
    [self.tableView setEditing:editing animated:animated];
}

#pragma Mark - Utility methods

+ (UILabel *)createCellLabel
{
    UILabel *label = [[[UILabel alloc] init] autorelease];
    label.textAlignment = UITextAlignmentLeft;
    label.opaque = NO;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:16.0];
    label.textColor = [UIColor blackColor];
    label.text = @"";
    label.adjustsFontSizeToFitWidth = YES;  
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    return label;
}

@end
