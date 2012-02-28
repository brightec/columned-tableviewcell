//
//  ColumedView.h
//  columned-tableview
//
//  Created by Cameron Cooke on 27/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColumedView : UIView

@property (nonatomic, retain) NSArray *columnWidths;
@property (nonatomic) BOOL selected;

- (id)initWithColumnWidths:(NSArray *)columnWidths frame:(CGRect)frame;

@end
