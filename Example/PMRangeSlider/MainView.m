//
// Created by Pawel Maczewski on 01/02/2017.
// Copyright (c) 2017 Pawel Maczewski. All rights reserved.
//

#import "MainView.h"
#import "PMRangeSliderView.h"
#import <Masonry/Masonry.h>

CGFloat const kMainViewDefaultMarginSize = 12.0f;
CGFloat const kMainViewDefaultSeparatorDistance = 120.0f;
CGFloat const kMainViewTextFieldWidth = 80.0f;

@interface MainView ()

@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) UILabel *firstLabel;
@property(nonatomic, strong) UILabel *secondLabel;
@property(nonatomic, strong) UITextField *lowTextField;
@property(nonatomic, strong) UITextField *highTextField;
@property(nonatomic, strong) PMRangeSliderView *rangeSliderView;
@property(nonatomic, strong) UISlider *nativeSlider;

@end

@implementation MainView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *scrollView = [UIScrollView new];
        [self addSubview:scrollView];
        scrollView.alwaysBounceVertical = YES;
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];

        self.contentView = [UIView new];
        [scrollView addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(scrollView);
            make.left.right.equalTo(self);
        }];

        _firstLabel = [UILabel new];
        _secondLabel = [UILabel new];
        _lowTextField = [UITextField new];
        _highTextField = [UITextField new];
        _rangeSliderView = [[PMRangeSliderView alloc] initWithFrame:CGRectZero from:1 to:157];
        _nativeSlider = [[UISlider alloc] initWithFrame:CGRectZero];
        [self setupView];
        [self setupTexts];
        [self setupSlider];
        [self setNeedsUpdateConstraints];
    }

    return self;
}

- (void)setupView {
    [self.contentView addSubview:self.firstLabel];
    [self.contentView addSubview:self.secondLabel];
    [self.contentView addSubview:self.lowTextField];
    [self.contentView addSubview:self.highTextField];
    [self.contentView addSubview:self.rangeSliderView];
    [self.contentView addSubview:self.nativeSlider];

    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(kMainViewDefaultMarginSize);
        make.right.equalTo(self.contentView).offset(-kMainViewDefaultMarginSize);
    }];

    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstLabel).offset(kMainViewDefaultSeparatorDistance);
        make.left.right.equalTo(self.firstLabel);
    }];

    [self.lowTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondLabel).offset(kMainViewDefaultSeparatorDistance);
        make.left.equalTo(self.secondLabel);
        make.width.equalTo(@(kMainViewTextFieldWidth));
    }];

    [self.rangeSliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lowTextField);
        make.height.equalTo(self.lowTextField);
        make.left.equalTo(self.lowTextField.mas_right).offset(kMainViewDefaultMarginSize);
    }];

    [self.highTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lowTextField);
        make.left.equalTo(self.rangeSliderView.mas_right).offset(kMainViewDefaultMarginSize);
        make.right.equalTo(self.firstLabel);
        make.width.equalTo(@(kMainViewTextFieldWidth));
    }];

    [self.nativeSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.rangeSliderView);
        make.width.equalTo(self.rangeSliderView);
        make.top.equalTo(self.rangeSliderView).offset(kMainViewDefaultSeparatorDistance);
        make.bottom.equalTo(self.contentView).offset(-kMainViewDefaultMarginSize);
    }];
}

- (void)setupTexts {
    self.firstLabel.text = @"Text goes here";
    self.secondLabel.text = @"Text goes here as well";
    self.lowTextField.placeholder = @"LOW";
    self.highTextField.placeholder = @"HIG";
}

- (void)setupSlider {
    self.rangeSliderView.currentMaximumValue = 100;
    self.rangeSliderView.currentMinimumValue = 30;
    self.rangeSliderView.tintColor = [UIColor redColor];
    self.nativeSlider.tintColor = self.rangeSliderView.tintColor;
}

@end