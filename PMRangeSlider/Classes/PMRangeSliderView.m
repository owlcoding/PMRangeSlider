//
// Created by Pawel Maczewski on 01/02/2017.
// Copyright (c) 2017 Pawel Maczewski. All rights reserved.
//

#import <BlocksKit/BlocksKit+UIKit.h>
#import "PMRangeSliderView.h"
#import "PMRangeSliderThumb.h"

CGFloat const kPMRangeSliderViewThumbDiameter = 29.0f;
CGFloat const kPMRangeSliderViewThumbMinimumDistance = 0.0f;
CGFloat const kPMRangeSliderViewLineHeight = 2.0f;

@interface PMRangeSliderView ()

@property(nonatomic, strong) PMRangeSliderThumb *leftThumb;
@property(nonatomic, strong) PMRangeSliderThumb *rightThumb;

@property(nonatomic, strong) UIView *leftSideLine;
@property(nonatomic, strong) UIView *betweenLine;
@property(nonatomic, strong) UIView *rightSideLine;

@property(nonatomic, assign) CGFloat currMinVal;
@property(nonatomic, assign) CGFloat currMaxVal;

@end

@implementation PMRangeSliderView

- (instancetype)initWithFrame:(CGRect)frame from:(CGFloat)from to:(CGFloat)to {
    self = [super initWithFrame:frame];
    if (self) {
        _from = from;
        _currMinVal = from;
        _to = to;
        _currMaxVal = to;
        
        _leftThumb = [[PMRangeSliderThumb alloc] initWithFrame:CGRectMake(0, 0, kPMRangeSliderViewThumbDiameter, kPMRangeSliderViewThumbDiameter)];
        _rightThumb = [[PMRangeSliderThumb alloc] initWithFrame:CGRectMake(0, 0, kPMRangeSliderViewThumbDiameter, kPMRangeSliderViewThumbDiameter)];
        
        _leftSideLine = [UIView new];
        _leftSideLine.layer.cornerRadius = kPMRangeSliderViewLineHeight / 2;
        [self addSubview:_leftSideLine];
        _betweenLine = [UIView new];
        [self addSubview:_betweenLine];
        _rightSideLine = [UIView new];
        _rightSideLine.layer.cornerRadius = kPMRangeSliderViewLineHeight / 2;
        [self addSubview:_rightSideLine];
        
        [self addSubview:_leftThumb];
        [self addSubview:_rightThumb];
        
        self.backgroundColor = [UIColor clearColor];
        [self setTintColor:nil];
        [self initialThumbsPositions];
        [self setupGestureRecognizers];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setCurrentMinimumValue:self.currMinVal];
    [self setCurrentMaximumValue:self.currMaxVal];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(2 * kPMRangeSliderViewThumbDiameter + 2.0f, kPMRangeSliderViewThumbDiameter + 2.0f);
}

- (void)initialThumbsPositions {
    CGFloat diameter = self.leftThumb.frame.size.width;
    [self moveThumb:self.leftThumb toHorizontalPosition:diameter / 2];
    [self moveThumb:self.rightThumb toHorizontalPosition:self.frame.size.width - diameter / 2];
}

- (void)moveThumb:(PMRangeSliderThumb *)thumb toHorizontalPosition:(CGFloat)x {
    thumb.center = CGPointMake(x, thumb.center.y);
    CGFloat lineYOrigin = thumb.center.y - kPMRangeSliderViewLineHeight / 2;
    self.leftSideLine.frame = CGRectMake(0, lineYOrigin, self.leftThumb.center.x, kPMRangeSliderViewLineHeight);
    self.rightSideLine.frame = CGRectMake(self.rightThumb.center.x,
                                          lineYOrigin,
                                          self.frame.size.width - self.rightThumb.center.x,
                                          kPMRangeSliderViewLineHeight);
    CGFloat distanceBetweenThumbs = self.rightSideLine.frame.origin.x - self.leftSideLine.frame.origin.x - self.leftSideLine.frame.size.width;
    self.betweenLine.frame = CGRectMake(CGRectGetMaxX(self.leftSideLine.frame),
                                        lineYOrigin,
                                        distanceBetweenThumbs,
                                        kPMRangeSliderViewLineHeight);
    if (self.rangeSliderViewDelegate && [self.rangeSliderViewDelegate respondsToSelector:@selector(rangeSlider:didChangeMinValue:maxValue:)]) {
        [self.rangeSliderViewDelegate rangeSlider:self didChangeMinValue:self.currentMinimumValue maxValue:self.currentMaximumValue];
    }
}

- (void)normalizeThumbHorizontalPosition:(PMRangeSliderThumb *)thumb {
    CGFloat diameter = self.leftThumb.frame.size.width;
    CGFloat x = MIN(MAX(thumb.center.x, diameter / 2), self.frame.size.width - diameter / 2);
    if (thumb == self.leftThumb) {
        x = MIN(x, self.rightThumb.frame.origin.x - kPMRangeSliderViewThumbMinimumDistance - diameter / 2);
    } else {
        x = MAX(x, self.leftThumb.frame.origin.x + diameter + kPMRangeSliderViewThumbMinimumDistance + diameter / 2);
    }
    [self moveThumb:thumb toHorizontalPosition:x];
}

- (void)setupGestureRecognizers {
    typeof(self) __weak weakSelf = self;
    void (^gestureRecognizerBlock)(UIGestureRecognizer *, UIGestureRecognizerState, CGPoint) = ^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        typeof(weakSelf) __strong strongSelf = weakSelf;
        CGFloat y = strongSelf.frame.size.height / 2;
        UIPanGestureRecognizer *panGestureRecognizer = (UIPanGestureRecognizer *) sender;
        CGPoint point = [panGestureRecognizer translationInView:strongSelf];
        CGFloat x = point.x + sender.view.center.x;
        sender.view.center = CGPointMake(x, y);
        [strongSelf normalizeThumbHorizontalPosition:(PMRangeSliderThumb *) sender.view];
        [panGestureRecognizer setTranslation:CGPointZero inView:strongSelf];
        if (sender.view == strongSelf.leftThumb) {
            strongSelf.currMinVal = [strongSelf currentMinimumValue];
        } else {
            strongSelf.currMaxVal = [strongSelf currentMaximumValue];
        }
        if (state == UIGestureRecognizerStateEnded) {
            if (strongSelf.rangeSliderViewDelegate && [self.rangeSliderViewDelegate respondsToSelector:@selector(rangeSlider:didStopChangingMinValue:maxValue:)]) {
                [strongSelf.rangeSliderViewDelegate rangeSlider:strongSelf didStopChangingMinValue:strongSelf.currentMinimumValue maxValue:strongSelf.currentMaximumValue];
            }
        }
    };
    
    UIPanGestureRecognizer *leftPanGesture = [[UIPanGestureRecognizer alloc] bk_initWithHandler:gestureRecognizerBlock];
    [self.leftThumb addGestureRecognizer:leftPanGesture];
    UIPanGestureRecognizer *rightPanGesture = [[UIPanGestureRecognizer alloc] bk_initWithHandler:gestureRecognizerBlock];
    [self.rightThumb addGestureRecognizer:rightPanGesture];
}

- (CGFloat)valueForHorizontalPosition:(CGFloat)x {
    CGFloat totalLength = self.frame.size.width - self.leftThumb.frame.size.width - self.rightThumb.frame.size.width;
    CGFloat val = self.from + (self.to - self.from) / totalLength * (x - self.leftThumb.frame.size.width);
    return val;
}

- (CGFloat)horizontalPositionForValue:(CGFloat)value {
    CGFloat totalLength = self.frame.size.width - self.leftThumb.frame.size.width - self.rightThumb.frame.size.width;
    CGFloat x = (value - self.from) / (self.to - self.from) * totalLength + self.leftThumb.frame.size.width;
    return x;
}

- (CGFloat)currentMinimumValue {
    return [self valueForHorizontalPosition:self.leftThumb.frame.origin.x + self.leftThumb.frame.size.width + kPMRangeSliderViewThumbMinimumDistance / 2];
}

- (void)setCurrentMinimumValue:(CGFloat)currentMinimumValue {
    self.currMinVal = currentMinimumValue;
    CGFloat x = [self horizontalPositionForValue:currentMinimumValue];
    [self moveThumb:self.leftThumb toHorizontalPosition:x - self.leftThumb.frame.size.width / 2];
    [self normalizeThumbHorizontalPosition:self.leftThumb];
}

- (CGFloat)currentMaximumValue {
    return [self valueForHorizontalPosition:self.rightThumb.frame.origin.x - kPMRangeSliderViewThumbMinimumDistance / 2];
}

- (void)setCurrentMaximumValue:(CGFloat)currentMaximumValue {
    self.currMaxVal = currentMaximumValue;
    CGFloat x = [self horizontalPositionForValue:currentMaximumValue];
    [self moveThumb:self.rightThumb toHorizontalPosition:x + self.rightThumb.frame.size.width / 2];
    [self normalizeThumbHorizontalPosition:self.rightThumb];
}

@end

@implementation PMRangeSliderView (Styling)

- (void)setColor:(UIColor *)color borderColor:(UIColor *)borderColor forThumb:(PMRangeSliderThumb *)thumb {
    thumb.backgroundColor = color;
    
    thumb.layer.shadowColor = color.CGColor;
    thumb.layer.borderWidth = 0.3f;
    thumb.layer.borderColor = borderColor.CGColor;
}

- (void)setColor:(UIColor *)color forLine:(UIView *)line {
    line.backgroundColor = color;
}

- (void)setTintColor:(UIColor *)tintColor {
    if (!tintColor) {
        tintColor = [[UIColor blueColor] colorWithAlphaComponent:0.6];
    }
    
    [self setColor:tintColor borderColor:[UIColor lightGrayColor] forThumb:self.leftThumb];
    [self setColor:tintColor borderColor:[UIColor lightGrayColor] forThumb:self.rightThumb];
    [self setColor:[UIColor lightGrayColor] forLine:self.leftSideLine];
    [self setColor:[UIColor lightGrayColor] forLine:self.rightSideLine];
    [self setColor:tintColor forLine:self.betweenLine];
}

@end
