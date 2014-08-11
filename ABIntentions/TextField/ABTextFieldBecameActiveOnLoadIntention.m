//
//  ABTextFieldBecameActiveOnLoadIntention.m
//  ABIntentionsDemo
//
//  Created by Антон Буков on 11.08.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import "ABTextFieldBecameActiveOnLoadIntention.h"

@implementation ABTextFieldBecameActiveOnLoadIntention

- (void)setResponder:(UIResponder *)responder
{
    _responder = responder;
    
    if (self.delay && self.delay.doubleValue == 0) {
        [responder becomeFirstResponder];
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.delay.doubleValue * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [responder becomeFirstResponder];
    });
}

@end
