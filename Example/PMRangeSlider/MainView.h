//
// Created by Pawel Maczewski on 01/02/2017.
// Copyright (c) 2017 Pawel Maczewski. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMRangeSliderView;

@interface MainView : UIView

@property(nonatomic, strong, readonly) UITextField *lowTextField;
@property(nonatomic, strong, readonly) UITextField *highTextField;
@property(nonatomic, strong, readonly) PMRangeSliderView *rangeSliderView;

@end