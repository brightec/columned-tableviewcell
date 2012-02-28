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
@property (nonatomic, retain) NSMutableArray *labels; 

- (id)initWithColumnWidths:(NSArray *)columnWidths isSelected:(BOOL)selected frame:(CGRect)frame;
- (UILabel *)labelForColumnIndex:(int)index;

@end
