//
//  ColumnedHeaderView.m
//  columned-tableview
//
//  Created by Cameron Cooke on 28/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ColumnedHeaderView.h"
#import "Common.h"

@implementation ColumnedHeaderView

@synthesize lightColour = _lightColour;
@synthesize darkColour = _darkColour;
@synthesize labels = _labels;

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithColumnWidths:[NSArray arrayWithObjects:[NSNumber numberWithInt:self.bounds.size.width], nil] frame:frame];
}

- (id)initWithColumnWidths:(NSArray *)columnWidths frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // set default values
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        self.labels = [NSMutableArray array];
        _columnWidths = [columnWidths retain];
        _margin = 9.0;
        
        // create cell labels
        for (int i = 0; i < [_columnWidths count]; i++) {
            
            // create label for column i
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = UITextAlignmentLeft;
            label.opaque = NO;
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont boldSystemFontOfSize:16.0];
            label.textColor = [UIColor whiteColor];
            label.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            label.shadowOffset = CGSizeMake(0, -1);
            label.text = [@"Label " stringByAppendingFormat:@"%i", i];
            label.adjustsFontSizeToFitWidth = YES;
            [self.labels addObject:label];
            [self addSubview:label];
            [label release];
        }
        
        // set colour properties
        self.lightColour = [UIColor colorWithRed:105.0f/255.0f green:179.0f/255.0f blue:216.0f/255.0f alpha:1.0];
        self.darkColour = [UIColor colorWithRed:21.0/255.0 green:92.0/255.0 blue:136.0/255.0 alpha:1.0];
    }
    return self;    
}

- (UILabel *)labelForColumnIndex:(int)index
{
    return (UILabel *)[self.labels objectAtIndex:index];
}

/**
 * Called when view changes size so adjust frames
 */
- (void)layoutSubviews
{
    // rect used for drawing the header
    CGFloat coloredBoxHeight = 40.0;
    _headerRect = CGRectMake(_margin, _margin, self.bounds.size.width-_margin*2, coloredBoxHeight);
    
    // set rects for labels
    int prevWidth = _margin;    
    for (int i = 0; i < [self.labels count]; i++) {
		
        UILabel *label = (UILabel *)[self.labels objectAtIndex: i];
        
        // calculate x pos and width
        CGFloat width = [((NSNumber *) [_columnWidths objectAtIndex:i]) floatValue];
        CGFloat left = prevWidth;
        
        // create rect based on above value and assign rect to label
        CGRect labelRect = CGRectMake(left+5, _margin, width-10, coloredBoxHeight);
        label.frame = labelRect;
        
        prevWidth = left+width;        
    }
    
    // give the title label the same frame as headerRect
//    CGRect titleRect = _headerRect;
//    titleRect.size.width = ((NSNumber *)[self.columnWidths objectAtIndex:0]).floatValue;
//    self.titleLabel.frame = titleRect;    
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // get core graphics color refs
    CGColorRef lightColor = _lightColour.CGColor;
    CGColorRef darkColor = _darkColour.CGColor;
    
    // draw glossy background to header rect
    drawGlossAndGradient(context, _headerRect, lightColor, darkColor);
    
    // add border around rect
    CGContextSetStrokeColorWithColor(context, darkColor); 
    CGContextSetLineWidth(context, 1.0);       
    CGContextStrokeRect(context, rectFor1PxStroke(_headerRect));   
    
    // draw vertical column seperator lines
    int prevWidth = _margin;
	for (int i = 0; i < [_columnWidths count]-1; i++) {
        
		CGFloat width = [((NSNumber *) [_columnWidths objectAtIndex:i]) floatValue];
        CGFloat left = width+prevWidth;
        
        // dark shadow
        CGContextSetStrokeColorWithColor(context, darkColor);
		CGContextMoveToPoint(context, left, _headerRect.origin.y+1);
		CGContextAddLineToPoint(context, left, CGRectGetMaxY(_headerRect));
        CGContextStrokePath(context);
        
        // light shadow
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:1 alpha:0.3].CGColor);
        CGContextMoveToPoint(context, left+1, _headerRect.origin.y+1);
        CGContextAddLineToPoint(context, left+1, CGRectGetMaxY(_headerRect));
        CGContextStrokePath(context);
        
        prevWidth = left;
	}     
}

-(void)dealloc
{
    self.labels = nil;
    self.lightColour = nil;
    self.darkColour = nil;
    [_columnWidths release];
    [super dealloc];
}

@end
