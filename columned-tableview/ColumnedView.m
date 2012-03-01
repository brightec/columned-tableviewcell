//
//  ColumnedView.m
//  columned-tableview
//
//  Created by Cameron Cooke on 01/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ColumnedView.h"

@implementation ColumnedView

@synthesize flexibleFirstColumn = _flexibleFirstColumn;

- (id)initWithFrame:(CGRect)frame
{
    NSArray *columnWidths = [NSArray arrayWithObjects:[NSNumber numberWithInt:self.bounds.size.width], nil];
    return [self initWithColumnWidths:columnWidths frame:frame];
}

- (id)initWithColumnWidths:(NSArray *)columnWidths frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.flexibleFirstColumn = NO;        
        _columnWidths = [columnWidths retain];        
    }
    return self;    
}

/**
 * Return the column width for the index column
 */
- (CGFloat)getWidthForColumn:(int)index
{
    CGFloat width = 0.0;
    
    if (self.flexibleFirstColumn && index == 0) {
        
        // get combined widths of all columns minus first
        CGFloat combined = 0.0;
        for (int i = 1; i < [_columnWidths count]; i++) {
            combined += [((NSNumber *)[_columnWidths objectAtIndex:i]) floatValue];
        }
        
        width = self.bounds.size.width - combined;
    }
    else {
        width = [((NSNumber *)[_columnWidths objectAtIndex:index]) floatValue];
    }
    
    return width;
}

- (void)dealloc
{
    [_columnWidths release];
    [super dealloc];
}

@end
