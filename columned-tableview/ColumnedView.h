//
//  ColumnedView.h
//  columned-tableview
//
//  Created by Cameron Cooke on 01/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColumnedView : UIView {
    NSArray *_columnWidths;    
}

@property (nonatomic) BOOL flexibleFirstColumn;

- (id)initWithColumnWidths:(NSArray *)columnWidths frame:(CGRect)frame;
- (CGFloat)getWidthForColumn:(int)index;

@end
