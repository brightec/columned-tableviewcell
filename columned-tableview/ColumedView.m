//
//  ColumedView.m
//  columned-tableview
//
//  Created by Cameron Cooke on 27/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ColumedView.h"
#import "Common.h"

@implementation ColumedView

@synthesize selected = _selected;
@synthesize cellContentViews = _cellContentViews;

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithColumnWidths:[NSArray arrayWithObjects:[NSNumber numberWithInt:self.bounds.size.width], nil] isSelected:NO frame:frame];
}

- (id)initWithColumnWidths:(NSArray *)columnWidths isSelected:(BOOL)selected frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
		self.opaque = YES;
        self.selected = selected;
        self.cellContentViews = [NSMutableArray array];
        _columnWidths = [columnWidths retain];
        
        // create cell content views
        for (int i = 0; i < [_columnWidths count]; i++) {
            
            UIView *contentView = [[UIView alloc] init];
            contentView.opaque = NO;
            contentView.backgroundColor = [UIColor clearColor];
            contentView.autoresizesSubviews = YES;
            
            [self.cellContentViews addObject:contentView];
            [self addSubview:contentView];
            [contentView release];
        } 
    }
    return self;
}

- (UIView *)cellContentViewForColumnIndex:(int)index
{
    return (UIView *)[self.cellContentViews objectAtIndex:index];
}

- (void)layoutSubviews
{
    // set rects for content views
    int prevWidth = 0;    
    for (int i = 0; i < [self.cellContentViews count]; i++) {
		
        UIView *contentView = (UIView *)[self.cellContentViews objectAtIndex: i];
        
        // calculate x pos and width
        CGFloat width = [((NSNumber *) [_columnWidths objectAtIndex:i]) floatValue];
        CGFloat left = prevWidth;
        
        // create rect based on above value and assign rect to content view
        CGRect contentViewRect = CGRectMake(left+5, 0, width-10, self.bounds.size.height);
        contentView.frame = contentViewRect;
        
        prevWidth = left+width;        
    }    
}

-(void)setSelected:(BOOL)selected {
    _selected = selected;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
    
    // draw background gradient
    CGColorRef startGradientColour = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
    CGColorRef endGradientColour = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0].CGColor;
    
    if(self.selected) {
        startGradientColour = [UIColor colorWithRed:0.0 green:170.0/255.0 blue:249.0/255.0 alpha:1.0].CGColor;
        endGradientColour = [UIColor colorWithRed:103.0/255.0 green:208.0/255.0 blue:255.0/255.0 alpha:1.0].CGColor;        
    }
    
    CGContextSaveGState(context);
    drawLinearGradient(context, rect, startGradientColour, endGradientColour);
    CGContextRestoreGState(context);
    
	CGContextSetLineWidth(context, 1);
    
    // draw vertical column seperator lines
    int prevWidth = 0;
	for (int i = 0; i < [_columnWidths count]-1; i++) {
        
		CGFloat width = [((NSNumber *) [_columnWidths objectAtIndex:i]) floatValue];
        CGFloat left = width+prevWidth;
        
        // dark shadow
        CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
		CGContextMoveToPoint(context, left, 0);
		CGContextAddLineToPoint(context, left, self.bounds.size.height);
        CGContextStrokePath(context);
        
        // light shadow
        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextMoveToPoint(context, left+1, 0);
        CGContextAddLineToPoint(context, left+1, self.bounds.size.height);
        CGContextStrokePath(context);
        
        prevWidth = left;
	}
    
    // draw seperator line
    CGRect strokeRect = rect;
    strokeRect.size.height = -1;
    strokeRect.origin.y = CGRectGetMinY(rect);
    strokeRect = rectFor1PxStroke(strokeRect);
    
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextStrokeRect(context, strokeRect);
    
    // draw left vertical line
//    CGContextMoveToPoint(context, 0, 0);
//    CGContextAddLineToPoint(context, 0, CGRectGetMaxY(rect));
//    CGContextStrokePath(context);
//
//    // draw right vertical line
//    CGContextMoveToPoint(context, CGRectGetMaxX(rect), 0);
//    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
//    CGContextStrokePath(context);    
    
	[super drawRect:rect];
}

- (void)dealloc
{
    [_columnWidths release];
    self.cellContentViews = nil;
    [super dealloc];
}

@end
