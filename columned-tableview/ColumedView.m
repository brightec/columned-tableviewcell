//
//  ColumedView.m
//  columned-tableview
//
//  Created by Cameron Cooke on 27/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ColumedView.h"

@implementation ColumedView

@synthesize columnWidths = _columnWidths;

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithColumnWidths:[NSArray arrayWithObjects:[NSNumber numberWithInt:self.bounds.size.width], nil] frame:frame];
}

- (id)initWithColumnWidths:(NSArray *)columnWidths frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.columnWidths = columnWidths;
		self.opaque = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIColor *bgColour = [UIColor redColor];
    [bgColour set];
    CGContextFillRect(ctx, rect);

	CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.5, 1.0);
	CGContextSetLineWidth(ctx, 0.25);
    
    // draw vertical column seperator lines
    int prevWidth = 0;
	for (int i = 0; i < [self.columnWidths count]; i++) {
        
		CGFloat width = [((NSNumber *) [self.columnWidths objectAtIndex:i]) floatValue];
		CGContextMoveToPoint(ctx, prevWidth+width, 0);
		CGContextAddLineToPoint(ctx, prevWidth+width, self.bounds.size.height);
        
        prevWidth = width;
	}
    
	CGContextStrokePath(ctx);
    
	[super drawRect:rect];
}

- (void)dealloc
{
    [_columnWidths release];
    [super dealloc];
}

@end
