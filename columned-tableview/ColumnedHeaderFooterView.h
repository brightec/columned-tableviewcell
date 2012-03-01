//
//  ColumnedHeaderView.h
//  columned-tableview
//
//  Created by Cameron Cooke on 28/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColumnedView.h"

typedef enum {
    ColumnedSectionTypeHeader,
    ColumnedSectionTypeFooter
} ColumnedSectionType;

@interface ColumnedHeaderFooterView : ColumnedView {
    CGRect _headerRect;
    CGFloat _margin;
    ColumnedSectionType _sectionType;
}

@property (nonatomic, retain) UIColor *lightColour;
@property (nonatomic, retain) UIColor *darkColour;
@property (nonatomic, retain) NSMutableArray *labels; 

- (id)initWithColumnWidths:(NSArray *)columnWidths frame:(CGRect)frame sectionType:(ColumnedSectionType)sectionType;
- (UILabel *)labelForColumnIndex:(int)index;

@end