//
//  ColumnedHeaderView.m
//  columned-tableview
//
//  Created by Cameron Cooke on 28/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ColumnedHeaderFooterView.h"
#import "Common.h"

@implementation ColumnedHeaderFooterView

@synthesize lightColour = _lightColour;
@synthesize darkColour = _darkColour;
@synthesize labels = _labels;

- (id)initWithColumnWidths:(NSArray *)columnWidths frame:(CGRect)frame sectionType:(ColumnedSectionType)sectionType
{
    self = [super initWithColumnWidths:columnWidths frame:frame];
    if (self) {
        
        // set default values
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        self.contentMode = UIViewContentModeRedraw;
        self.labels = [NSMutableArray array];
        _sectionType = sectionType;
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
    
    // if header add top margin
    int topMargin = 0;
    if(_sectionType == ColumnedSectionTypeHeader) {
        topMargin = _margin;
    }    
    
    // rect for drawing rounded rectangle
    _headerRect = CGRectMake(_margin, topMargin, self.bounds.size.width-_margin*2, coloredBoxHeight);
    
    // layout labels
    int prevWidth = _margin;
    for (int i = 0; i < [self.labels count]; i++) {
		
        UILabel *label = (UILabel *)[self.labels objectAtIndex: i];
        
        // calculate x pos and width
        CGFloat width = [self getWidthForColumn:i];
        CGFloat left = prevWidth;
        
        // create rect based on above value and assign rect to label
        CGRect labelRect = CGRectMake(left+5, topMargin, width-10, coloredBoxHeight);
        label.frame = labelRect;
        
        prevWidth = left+width;        
    } 
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat radius = 3;
    
    // get core graphics color refs
    CGColorRef lightColor = _lightColour.CGColor;
    CGColorRef darkColor = _darkColour.CGColor;
    
    CGContextSetFillColorWithColor(context, lightColor);
    CGContextSetStrokeColorWithColor(context, darkColor);
    CGContextSetLineWidth(context, 1.0);       
    
    CGContextSaveGState(context);    
    
    if (_sectionType == ColumnedSectionTypeHeader) {
        drawRoundedRect(context, _headerRect, radius, radius, 0, 0);
        drawGlossAndGradient(context, _headerRect, lightColor, darkColor);        
    }
    else {       
        drawRoundedRect(context, _headerRect, 0, 0, radius, radius);        
        drawLinearGradient(context, _headerRect, lightColor, darkColor);
    }
    
    CGContextRestoreGState(context);    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);   
    
    // draw vertical column seperator lines
    int prevWidth = _margin;
	for (int i = 0; i < [_columnWidths count]-1; i++) {
        
		CGFloat width = [self getWidthForColumn:i];
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

    // draw horizontal seperator line if footer
    if (_sectionType == ColumnedSectionTypeFooter) {
        
        CGContextSaveGState(context); 
        
        // add inner shadow to footer
        CGContextSetShadowWithColor(context, CGSizeMake(0.0, 0.0), 3.0, [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5].CGColor); 
        
        CGRect strokeRect = _headerRect;
        strokeRect.size.height = -1;
        strokeRect.origin.y = CGRectGetMinY(_headerRect);
        strokeRect = rectFor1PxStroke(strokeRect);        
        CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
        CGContextStrokeRect(context, strokeRect);        
        
        CGContextRestoreGState(context); 
    }
}

- (CGFloat)getWidthForColumn:(int)index
{
    CGFloat width = [super getWidthForColumn:index];
    
    // adjust for margin
    if (self.flexibleFirstColumn && index == 0) {
        width = width - (_margin*2);
    }
    
    return width;
}

-(void)dealloc
{
    self.labels = nil;
    self.lightColour = nil;
    self.darkColour = nil;
    [super dealloc];
}

@end
