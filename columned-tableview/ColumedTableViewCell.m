//
//  ColumedTableViewCell.m
//  columned-tableview
//
//  Created by Cameron Cooke on 27/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ColumedTableViewCell.h"

@implementation ColumedTableViewCell

@synthesize columedView = _columedView;

- (id)initWithColumnWidths:(NSArray *)columnWidths reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        
		CGRect viewFrame = CGRectMake(0.0, 0.0, self.backgroundView.bounds.size.width, self.backgroundView.bounds.size.height);
        
        self.columedView = [[[ColumedView alloc] initWithColumnWidths:columnWidths isSelected:NO frame:viewFrame] autorelease];
        self.columedView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundView = self.columedView;
        
        self.selectedBackgroundView = [[UIView alloc] init];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
    [self.columedView setSelected:selected];
}

- (void)dealloc
{
    self.columedView = nil;
    [super dealloc];
}

@end
