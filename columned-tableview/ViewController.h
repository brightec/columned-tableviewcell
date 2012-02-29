//
//  ViewController.h
//  columned-tableview
//
//  Created by Cameron Cooke on 27/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *_columnWidths;
}

@property (retain, nonatomic) IBOutlet UITableView *tableView;

+ (UILabel *)createCellLabel;

@end
