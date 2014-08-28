//
//  ABTextFieldPlaceholderColor.m
//  ABIntentionsDemo
//
//  Created by Антон Буков on 28.08.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import "ABTextFieldPlaceholderColor.h"

@interface ABTextFieldPlaceholderColor ()

@end

@implementation ABTextFieldPlaceholderColor

- (void)setTextFields:(NSArray *)textFields
{
    _textFields = textFields;
    
    UIColor *color = [UIColor colorWithRed:self.r.integerValue/255.0
                                     green:self.g.integerValue/255.0
                                      blue:self.b.integerValue/255.0
                                     alpha:1.0];
    for (UITextField *textField in textFields) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textField.placeholder attributes:@{NSForegroundColorAttributeName:color}];
    }
}

@end
