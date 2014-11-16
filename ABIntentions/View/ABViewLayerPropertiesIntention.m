//
//  ABViewLayerRoundCorners.m
//  ABIntentionsDemo
//
//  Created by Антон Буков on 14.11.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import "ABViewLayerPropertiesIntention.h"

@implementation ABViewLayerPropertiesIntention

- (void)setViews:(NSArray *)views
{
    _views = views;
    [self applyRadius];
}

- (void)setCornerRadius:(NSNumber *)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self applyRadius];
}

- (void)setBorderWidth:(NSNumber *)borderWidth
{
    _borderWidth = borderWidth;
    [self applyRadius];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    [self applyRadius];
}

- (void)applyRadius
{
    for (UIView *view in self.views) {
        view.layer.cornerRadius = self.cornerRadius.doubleValue;
        view.layer.borderWidth = self.borderWidth.doubleValue;
        view.layer.borderColor = self.borderColor.CGColor;
        view.layer.masksToBounds = YES;
    }
}

@end
