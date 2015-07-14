//
//  RatingViewController.h
//  RatingController
//
//  Created by Ajay on 2/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RatingViewDelegate;
@interface RatingView : UIView {
	UIImageView *s1, *s2, *s3, *s4, *s5;
	UIImage *unselectedImage, *partlySelectedImage, *fullySelectedImage;
//	id<RatingViewDelegate> delegate;

	float starRating, lastRating;
	float height, width; // of each image of the star!
    float _offset;
}
@property (nonatomic, retain) UIImage *unselectedImage;
@property (nonatomic, retain) UIImage *partlySelectedImage;
@property (nonatomic, retain) UIImage *fullySelectedImage;

@property (nonatomic, strong) UIImage *badSelectImage;
@property (nonatomic, strong) UIImage *badPartSelectImage;
@property (nonatomic, assign) float badRating; // 什么时候显示 badImage 如果为3，则小于等于3.0 都显示 badImage

@property (nonatomic, assign) BOOL canCancelRating;

@property (nonatomic, retain) UIImageView *s1;
@property (nonatomic, retain) UIImageView *s2;
@property (nonatomic, retain) UIImageView *s3;
@property (nonatomic, retain) UIImageView *s4;
@property (nonatomic, retain) UIImageView *s5;

@property (nonatomic, assign) id<RatingViewDelegate> delegate;

//-(void)setImagesDeselected:(NSString *)unselectedImage partlySelected:(NSString *)partlySelectedImage 
//			  fullSelected:(NSString *)fullSelectedImage andDelegate:(id<RatingViewDelegate>)d;
-(void)setImagesDeselected:(NSString *)deselectedImage
			partlySelected:(NSString *)halfSelectedImage
			  fullSelected:(NSString *)fullSelectedImage
                    offset:(CGFloat)offset
			   andDelegate:(id<RatingViewDelegate>)d;
-(void)displayRating:(float)rating;
-(float)rating;

@end


@protocol RatingViewDelegate<NSObject>
-(void)ratingView:(RatingView *)ratingView ratingChanged:(float)newRating;
@end