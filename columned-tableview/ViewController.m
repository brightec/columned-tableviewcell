//
//  ViewController.m
//  columned-tableview
//
//  Created by Cameron Cooke on 27/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ColumedTableViewCell.h"
#import "ColumnedHeaderView.h"

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
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    _columnWidths = [NSArray arrayWithObjects:
                     [NSNumber numberWithInt:150], 
                     [NSNumber numberWithInt:50], 
                     [NSNumber numberWithInt:50], 
                     [NSNumber numberWithInt:50], nil];
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"MyCell";

// not working - crashed
//    ColumedTableViewCell *cell = (ColumedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
//    if (cell == nil) {
//        cell = [[[ColumedTableViewCell alloc] initWithColumnWidths: _columnWidths reuseIdentifier:cellId] autorelease];
//    }
    
    ColumedTableViewCell *cell = [[[ColumedTableViewCell alloc] initWithColumnWidths: _columnWidths reuseIdentifier:cellId] autorelease];
    
    // set column headers
    [[cell.columedView labelForColumnIndex:0] setText:@"Electricity bill"];
    [[cell.columedView labelForColumnIndex:1] setText:@"£125"];
    [[cell.columedView labelForColumnIndex:2] setText:@"£145"];  
    
    UILabel *statusLabel = [cell.columedView labelForColumnIndex:3];
    statusLabel.text = @"OK";
    statusLabel.textAlignment = UITextAlignmentCenter;
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 49;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ColumnedHeaderView *header = [[[ColumnedHeaderView alloc] initWithColumnWidths:_columnWidths frame:CGRectMake(0, 0, 320, [self tableView:tableView heightForHeaderInSection:section])] autorelease];
    
    if (section == 1) {
        header.lightColour = [UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:44.0/255.0 alpha:1.0];
        header.darkColour = [UIColor colorWithRed:255.0/255.0 green:142.0/255.0 blue:7.0/255.0 alpha:1.0];
    }
    else  if(section == 2) {
        header.lightColour = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0];
        header.darkColour = [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0];        
    }
    
    // set column headers
    [[header labelForColumnIndex:0] setText:@"Expenditure"];
    [[header labelForColumnIndex:1] setText:@"Budget"];
    [[header labelForColumnIndex:2] setText:@"Actual"];
    [[header labelForColumnIndex:3] setText:@"Status"];
    
    return header;
}

@end
