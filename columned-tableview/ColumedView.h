//
//  ColumedView.h
//  columned-tableview
//
//  Created by Cameron Cooke on 27/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColumedView : UIView {
    NSArray *_columnWidths;   
}

@property (nonatomic) BOOL selected;
@property (nonatomic, retain) NSMutableArray *cellContentViews; 

- (id)initWithColumnWidths:(NSArray *)columnWidths isSelected:(BOOL)selected frame:(CGRect)frame;
- (UIView *)cellContentViewForColumnIndex:(int)index;

@end
