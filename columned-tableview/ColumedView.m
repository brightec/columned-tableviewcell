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

@synthesize columnWidths = _columnWidths;
@synthesize selected = _selected;

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
        self.selected = NO;
    }
    return self;
}

-(void)setSelected:(BOOL)selected {
    _selected = selected;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // draw background gradient
    CGColorRef startGradientColour = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
    CGColorRef endGradientColour = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0].CGColor;
    
    if(self.selected) {
        startGradientColour = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
        endGradientColour = [UIColor colorWithRed:31.0/255.0 green:100.0/255.0 blue:255.0/255.0 alpha:1.0].CGColor;        
    }
    
    drawLinearGradient(ctx, rect, startGradientColour, endGradientColour);
    

	CGContextSetLineWidth(ctx, 1);
    
    // draw vertical column seperator lines
    int prevWidth = 0;
	for (int i = 0; i < [self.columnWidths count]-1; i++) {
        
		CGFloat width = [((NSNumber *) [self.columnWidths objectAtIndex:i]) floatValue];
        CGFloat left = width+prevWidth;
        
        // dark shadow
        CGContextSetStrokeColorWithColor(ctx, [UIColor grayColor].CGColor);
		CGContextMoveToPoint(ctx, left, 0);
		CGContextAddLineToPoint(ctx, left, self.bounds.size.height);
        CGContextStrokePath(ctx);
        
        // light shadow
        CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
        CGContextMoveToPoint(ctx, left+1, 0);
        CGContextAddLineToPoint(ctx, left+1, self.bounds.size.height);
        CGContextStrokePath(ctx);
        
        prevWidth = left;
	}
    
	[super drawRect:rect];
}

- (void)dealloc
{
    [_columnWidths release];
    [super dealloc];
}

@end
