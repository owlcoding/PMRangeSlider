//
// Created by Pawel Maczewski on 01/02/2017.
// Copyright (c) 2017 Pawel Maczewski. All rights reserved.
//

#import "PMRangeSliderThumb.h"

@implementation PMRangeSliderThumb

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        self.clipsToBounds = YES;
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = frame.size.width / 2;
        self.layer.shadowOpacity = 0.45;
        self.layer.shadowRadius = 2;
        self.layer.shadowOffset = CGSizeMake(2, 2);
    }

    return self;
}

@end