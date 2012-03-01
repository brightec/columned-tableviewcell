//
//  ColumedTableViewCell.m
//  columned-tableview
//
//  Created by Cameron Cooke on 27/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ColumedTableViewCell.h"

@implementation ColumedTableViewCell

@synthesize cellContentViews = _cellContentViews;
@synthesize flexibleFirstColumn = _flexibleFirstColumn;
@synthesize position = _position;

- (id)initWithColumnWidths:(NSArray *)columnWidths reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // set default ivar values
        _columnWidths = [columnWidths retain];
        self.flexibleFirstColumn = NO;
        self.cellContentViews = [NSMutableArray array];
        self.position = ColumedTableViewCellPositionMiddle;
        _horizontalMargin = 9.0;
        
        // background view that draws cells and background gradients
		CGRect viewFrame = CGRectMake(_horizontalMargin, 0.0, self.contentView.bounds.size.width-_horizontalMargin*2, self.contentView.bounds.size.height);
        
        CellColumnView *cellColumnView = [[[CellColumnView alloc] initWithColumnWidths:columnWidths isSelected:NO frame:viewFrame] autorelease];
        cellColumnView.contentMode = UIViewContentModeRight;        
        cellColumnView.cell = self;
        cellColumnView.flexibleFirstColumn = YES;
        cellColumnView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundView = cellColumnView;
        
        // use KVO to detect changes to frame
        [self.contentView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:NULL];
        
        // blank view for the selected backgroundstate
        self.selectedBackgroundView = [[[UIView alloc] init] autorelease];
        
        // create cell content views
        self.contentView.frame = viewFrame;
        for (int i = 0; i < [_columnWidths count]; i++) {
            
            UIView *contentView = [[UIView alloc] init];
            contentView.opaque = NO;
            contentView.backgroundColor = [UIColor clearColor];
            contentView.autoresizesSubviews = YES;
            
            [self.cellContentViews addObject:contentView];
            [self.contentView addSubview:contentView];
            [contentView release];
        } 
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // self.contentView's frame has changed (by edit mode) so force a redraw self.backgroundView
    [self.backgroundView setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{   
    [((CellColumnView *)self.backgroundView) setSelected:selected];    
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];   
}

- (UIView *)cellContentViewForColumnIndex:(int)index
{
    return (UIView *)[self.cellContentViews objectAtIndex:index];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // set rects for content views
    int prevWidth = 0;    
    for (int i = 0; i < [self.cellContentViews count]; i++) {
		
        UIView *contentView = (UIView *)[self.cellContentViews objectAtIndex: i];
        
        // calculate x pos and width
        CGFloat width = [self getWidthForColumn:i];
        
        CGFloat left = prevWidth;
        
        // create rect based on above value and assign rect to content view
        CGRect contentViewRect = CGRectMake(left+5, 0, width-10, self.bounds.size.height);
        contentView.frame = contentViewRect;
        
        prevWidth = left+width;        
    }    
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
        
        width = self.backgroundView.bounds.size.width - combined;
    }
    else {
        width = [((NSNumber *)[_columnWidths objectAtIndex:index]) floatValue];
    }
    
    return width;
}

- (void)dealloc
{
    self.cellContentViews = nil;   
    [self.contentView removeObserver:self forKeyPath:@"frame"];
    [super dealloc];
}

@end
