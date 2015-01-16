//
//  UILabelWithTrueHeight.m
//  ABIntentionsDemo
//
//  Created by Антон Буков on 17.11.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import "UILabelWithTrueHeight.h"

@implementation UILabelWithTrueHeight

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self calculateHeight];
    }
    return self;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self calculateHeight];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self calculateHeight];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self calculateHeight];
}

- (void)calculateHeight
{
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight &&
            constraint.secondItem == nil)
        {
            /*
            if (self.attributedText) {
                constraint.constant = [self.attributedText boundingRectWithSize:CGSizeMake(self.frame.size.width, FLT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin) context:nil].size.height;
            } else if (self.text) {
                constraint.constant = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, FLT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:self.font} context:nil].size.height;
            }*/
            constraint.constant = [self sizeThatFits:CGSizeMake(self.frame.size.width, FLT_MAX)].height;
            [self.superview layoutIfNeeded];
        }
    }
}

@end
