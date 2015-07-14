//
//  RatingViewController.m
//  RatingController
//
//  Created by Ajay on 2/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RatingView.h"

@implementation RatingView

@synthesize s1, s2, s3, s4, s5;
@synthesize unselectedImage,partlySelectedImage,fullySelectedImage;

- (void)dealloc {
//	[s1 release];
//	[s2 release];
//	[s3 release];
//	[s4 release];
//	[s5 release];
//    [super dealloc];
    
    s1 = nil;
    s2 = nil;
    s3 = nil;
    s4 = nil;
    s5 = nil;
}

- (void)removeSubviews
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    self.s1 = nil;
    self.s2 = nil;
    self.s3 = nil;
    self.s4 = nil;
    self.s5 = nil;
}

-(void)setImagesDeselected:(NSString *)deselectedImage
			partlySelected:(NSString *)halfSelectedImage
			  fullSelected:(NSString *)fullSelectedImage
                    offset:(CGFloat)offset
			   andDelegate:(id<RatingViewDelegate>)d {
    [self removeSubviews];
    
	self.unselectedImage = [UIImage imageNamed:deselectedImage];
	self.partlySelectedImage = halfSelectedImage == nil ? self.unselectedImage : [UIImage imageNamed:halfSelectedImage];
	self.fullySelectedImage = [UIImage imageNamed:fullSelectedImage];
	_delegate = d;
	
	height=0.0; width=0.0;
    _offset = offset;
	if (height < [fullySelectedImage size].height) {
		height = [fullySelectedImage size].height;
	}
	if (height < [partlySelectedImage size].height) {
		height = [partlySelectedImage size].height;
	}
	if (height < [unselectedImage size].height) {
		height = [unselectedImage size].height;
	}
	if (width < [fullySelectedImage size].width) {
		width = [fullySelectedImage size].width;
	}
	if (width < [partlySelectedImage size].width) {
		width = [partlySelectedImage size].width;
	}
	if (width < [unselectedImage size].width) {
		width = [unselectedImage size].width;
	}
	
	starRating = 0;
	lastRating = 0;
	s1 = [[UIImageView alloc] initWithImage:unselectedImage];
	s2 = [[UIImageView alloc] initWithImage:unselectedImage];
	s3 = [[UIImageView alloc] initWithImage:unselectedImage];
	s4 = [[UIImageView alloc] initWithImage:unselectedImage];
	s5 = [[UIImageView alloc] initWithImage:unselectedImage];
	
	[s1 setFrame:CGRectMake(0,0, width, height)];
//    s1.backgroundColor=[UIColor redColor];
//    s2.backgroundColor=[UIColor redColor];
//    s3.backgroundColor=[UIColor redColor];
//    s4.backgroundColor=[UIColor redColor];
//    s5.backgroundColor=[UIColor redColor];
	[s2 setFrame:CGRectMake(width+offset,     0, width, height)];
	[s3 setFrame:CGRectMake(2 * width+2*offset, 0, width, height)];
	[s4 setFrame:CGRectMake(3 * width+3*offset, 0, width, height)];
	[s5 setFrame:CGRectMake(4 * width+4*offset, 0, width, height)];
	
	[s1 setUserInteractionEnabled:NO];
	[s2 setUserInteractionEnabled:NO];
	[s3 setUserInteractionEnabled:NO];
	[s4 setUserInteractionEnabled:NO];
	[s5 setUserInteractionEnabled:NO];
	
	[self addSubview:s1];
	[self addSubview:s2];
	[self addSubview:s3];
	[self addSubview:s4];
	[self addSubview:s5];
	
	CGRect frame = [self frame];
    if (frame.size.width < CGRectGetMaxX(s5.frame)) {
        frame.size.width = CGRectGetMaxX(s5.frame);
    }
	if (frame.size.height < height) {
        frame.size.height = height;
    }
	[self setFrame:frame];
}

-(void)displayRating:(float)rating {
	[s1 setImage:self.unselectedImage];
	[s2 setImage:self.unselectedImage];
	[s3 setImage:self.unselectedImage];
	[s4 setImage:self.unselectedImage];
	[s5 setImage:self.unselectedImage];
	
    if (rating <= self.badRating) {
        [self displayRating:rating withFullSelectImage:self.badSelectImage partSelectImage:self.badPartSelectImage];
    } else {
        [self displayRating:rating withFullSelectImage:self.fullySelectedImage partSelectImage:self.partlySelectedImage];
    }
	
	
	starRating = rating;
	lastRating = rating;
    
}

- (void)displayRating:(float)rating withFullSelectImage:(UIImage *)fullSelectImage partSelectImage:(UIImage *)partSelectImage
{
    if (rating > 0.0 && rating < 1.0f) {
        [s1 setImage:partSelectImage];
    }
    if (rating >= 1.0f) {
        [s1 setImage:fullSelectImage];
    }
    if (rating > 1.0f && rating < 2.0f) {
        [s2 setImage:partSelectImage];
    }
    if (rating >= 2.0f) {
        [s2 setImage:fullSelectImage];
    }
    if (rating > 2.0f && rating < 3.0f) {
        [s3 setImage:partSelectImage];
    }
    if (rating >= 3) {
        [s3 setImage:fullSelectImage];
    }
    if (rating > 3.0 && rating < 4.0f) {
        [s4 setImage:partSelectImage];
    }
    if (rating >= 4) {
        [s4 setImage:fullSelectImage];
    }
    if (rating > 4.0 && rating < 5.0f) {
        [s5 setImage:partSelectImage];
    }
    if (rating >= 5) {
        [s5 setImage:fullSelectImage];
    }
}

-(void) touchesBegan: (NSSet *)touches withEvent: (UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self];
    [self displayRatingAtPoint:pt];
    
    if ([_delegate respondsToSelector:@selector(ratingView:ratingChanged:)]) {
        [_delegate ratingView:self ratingChanged:starRating];
    }
}

-(void) touchesMoved: (NSSet *)touches withEvent: (UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
	CGPoint pt = [[touches anyObject] locationInView:self];
    [self displayRatingAtPoint:pt];
    
    if ([_delegate respondsToSelector:@selector(ratingView:ratingChanged:)]) {
        [_delegate ratingView:self ratingChanged:starRating];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//	CGPoint pt = [[touches anyObject] locationInView:self];
//    [self displayRatingAtPoint:pt];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)displayRatingAtPoint:(CGPoint)pt
{
    int newRating = (int) (pt.x / (width+_offset)) + 1;
	if (newRating < 1 || newRating > 5)
		return;
	
	if (newRating != lastRating) {
		[self displayRating:newRating];
    } else {
        // 如果多次点击 第一颗星，则认为是0颗星
        if (self.canCancelRating && lastRating == 1 && newRating == 1) {
            [self displayRating:0];
        }
    }
}

-(float)rating {
    
	return starRating;
}

@end
