//
//  ABDelegateArrayIntention.m
//  ABIntentionsDemo
//
//  Created by Anton Bukov on 27.04.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ABDelegateArrayIntention.h"

@interface ABDelegateArrayIntention ()

@property (strong, nonatomic) IBOutletCollection(id) NSArray *delegates;

@end

@implementation ABDelegateArrayIntention

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector])
        return YES;
    
    for (id delegate in self.delegates)
        if ([delegate respondsToSelector:aSelector])
            return YES;
    
    return NO;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([super respondsToSelector:anInvocation.selector]) {
        [anInvocation invoke];
        return;
    }
    
    for (id delegate in self.delegates)
        if ([delegate respondsToSelector:anInvocation.selector])
            [anInvocation invokeWithTarget:delegate];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *method = [super methodSignatureForSelector:aSelector];
    if (method)
        return method;
    
    for (id delegate in self.delegates) {
        NSMethodSignature *method = [delegate methodSignatureForSelector:aSelector];
        if (method)
            return method;
    }
    return nil;
}

@end
