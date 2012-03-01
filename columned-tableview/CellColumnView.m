//
//  ColumedView.m
//  columned-tableview
//
//  Created by Cameron Cooke on 27/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CellColumnView.h"
#import "Common.h"

@implementation CellColumnView

@synthesize selected = _selected;
@synthesize cell = _cell;

- (id)initWithColumnWidths:(NSArray *)columnWidths isSelected:(BOOL)selected frame:(CGRect)frame
{
    self = [super initWithColumnWidths:columnWidths frame:frame];
    if (self) {
		self.opaque = YES;
        self.selected = selected;
    }    
    return self;
}

-(void)setSelected:(BOOL)selected {
    _selected = selected;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorRef strokeColour = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0].CGColor;
    
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

		CGFloat width = [self getWidthForColumn:i];
        
        CGFloat left = width+prevWidth;
        
        // dark shadow
        CGContextSetStrokeColorWithColor(context, strokeColour);
		CGContextMoveToPoint(context, left, 0);
		CGContextAddLineToPoint(context, left, self.bounds.size.height);
        CGContextStrokePath(context);
        
        // light shadow
        CGColorRef lightColour;
        if (self.selected) {
            lightColour = endGradientColour;
        }
        else {
            lightColour = [UIColor whiteColor].CGColor;
        }
        
        CGContextSetStrokeColorWithColor(context, lightColour);
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
    
    CGContextSetStrokeColorWithColor(context, strokeColour);
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

@end
