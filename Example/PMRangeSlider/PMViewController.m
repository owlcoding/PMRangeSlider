//
//  OMViewController.m
//  PMRangeSlider
//
//  Created by Pawel Maczewski on 01/02/2017.
//  Copyright (c) 2017 Pawel Maczewski. All rights reserved.
//

#import "PMViewController.h"
#import "MainView.h"
#import <PMRangeSlider/PMRangeSliderView.h>
#import "PMRangeSliderView.h"

@interface PMViewController () <PMRangeSliderViewDelegate>

@end

@implementation PMViewController

- (void)loadView {
    self.view = [MainView new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainView.rangeSliderView.rangeSliderViewDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MainView *)mainView {
    return (MainView *)self.view;
}

#pragma mark - PMRangeSliderViewDelegate

- (void)rangeSlider:(PMRangeSliderView *)rangeSlider didChangeMinValue:(CGFloat)minValue maxValue:(CGFloat)maxValue {
    self.mainView.lowTextField.text = [NSString stringWithFormat:@"%.1f", minValue];
    self.mainView.highTextField.text = [NSString stringWithFormat:@"%.1f", maxValue];
}

@end
