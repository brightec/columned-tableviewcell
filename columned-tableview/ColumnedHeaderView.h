//
//  ColumnedHeaderView.h
//  columned-tableview
//
//  Created by Cameron Cooke on 28/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColumnedHeaderView : UIView {
    CGRect _headerRect;
    CGFloat _margin;
    NSArray *_columnWidths;    
}

@property (nonatomic, retain) UIColor *lightColour;
@property (nonatomic, retain) UIColor *darkColour;
@property (nonatomic, retain) NSMutableArray *labels; 

- (id)initWithColumnWidths:(NSArray *)columnWidths frame:(CGRect)frame;
- (UILabel *)labelForColumnIndex:(int)index;

@end