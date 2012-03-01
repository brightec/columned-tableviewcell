//
//  ColumedTableViewCell.h
//  columned-tableview
//
//  Created by Cameron Cooke on 27/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellColumnView.h"

typedef enum {
    ColumedTableViewCellPositionMiddle = 1,
    ColumedTableViewCellPositionTop = 2,
    ColumedTableViewCellPositionBottom = 3,
    ColumedTableViewCellPositionTopBottom = 4    
} ColumedTableViewCellPosition;

@interface ColumedTableViewCell : UITableViewCell {
    NSArray *_columnWidths;
    int _horizontalMargin;
}

@property (nonatomic, retain) NSMutableArray *cellContentViews; 
@property (nonatomic) BOOL flexibleFirstColumn;
@property (nonatomic) ColumedTableViewCellPosition position;

- (id)initWithColumnWidths:(NSArray *)columnWidths reuseIdentifier:(NSString *)reuseIdentifier;
- (UIView *)cellContentViewForColumnIndex:(int)index;
- (CGFloat)getWidthForColumn:(int)index;

@end
