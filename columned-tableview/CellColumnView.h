//
//  ColumedView.h
//  columned-tableview
//
//  Created by Cameron Cooke on 27/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColumnedView.h"

@interface CellColumnView : ColumnedView

@property (nonatomic) BOOL selected;
@property (nonatomic, assign) UITableViewCell *cell; 

- (id)initWithColumnWidths:(NSArray *)columnWidths isSelected:(BOOL)selected frame:(CGRect)frame;

@end
