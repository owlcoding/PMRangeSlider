//
// Created by Pawel Maczewski on 01/02/2017.
// Copyright (c) 2017 Pawel Maczewski. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMRangeSliderView;

@protocol PMRangeSliderViewDelegate <NSObject>

@optional
- (void)rangeSlider:(PMRangeSliderView *)rangeSlider didChangeMinValue:(CGFloat)minValue maxValue:(CGFloat)maxValue;

@end

@interface PMRangeSliderView : UIView

@property (nonatomic, assign) CGFloat from;
@property (nonatomic, assign) CGFloat to;
@property (nonatomic, assign) CGFloat currentMinimumValue;
@property (nonatomic, assign) CGFloat currentMaximumValue;
@property (nonatomic, weak) id<PMRangeSliderViewDelegate> rangeSliderViewDelegate;

- (instancetype)initWithFrame:(CGRect)frame from:(CGFloat)from to:(CGFloat)to;

@end

@interface PMRangeSliderView (Styling)

@end