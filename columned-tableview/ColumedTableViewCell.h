//
//  ColumedTableViewCell.h
//  columned-tableview
//
//  Created by Cameron Cooke on 27/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColumedView.h"

@interface ColumedTableViewCell : UITableViewCell

@property (nonatomic, retain) ColumedView *columedView;

- (id)initWithColumnWidths:(NSArray *)columnWidths reuseIdentifier:(NSString *)reuseIdentifier;

@end
