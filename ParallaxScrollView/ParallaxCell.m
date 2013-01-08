//
//  ParallaxCell.m
//  ParallaxScrollView
//
//  Created by Andrew Pouliot on 1/7/13.
//  Copyright (c) 2013 Darknoon. All rights reserved.
//

#import "ParallaxCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation ParallaxCell

- (void)layoutSubviews;
{
	[super layoutSubviews];
	self.imageView.frame = self.contentView.bounds;
}

- (void)updateContentsRect;
{
	float yPos = 2.0 * (_offset / _totalHeight - 0.5); //normalized y-position (-1 to 1)
	float k = 0.7f; //parallax ratio
	float w = self.bounds.size.width;
	float h = self.bounds.size.height;
	
	// We want the center of the crop to be at 0.5 when yPos = 0,
	// and seem to move vertically by (k - 1.0) * contentSize.height pixels at each extreme.
	// w in pixels equates to 1.0 in contentRect because the image is square
	
	float center = 0.5 - (k - 1.0) * 0.5 * _totalHeight/w * yPos;
	
	self.imageView.layer.contentsRect = (CGRect){
		.origin.x = 0.0,
		.origin.y = center - 0.5 * h/w,
		.size.width = w/w,
		.size.height = h/w,
	};
}

- (void)setOffset:(CGFloat)offset;
{
	_offset = offset;
	[self updateContentsRect];
}

- (void)setTotalHeight:(CGFloat)totalHeight;
{
	_totalHeight = totalHeight;
	[self updateContentsRect];
}

@end
