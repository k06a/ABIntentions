//
//  ABBarButtonItemMultipleObserversIntention.m
//  ABIntentionsDemo
//
//  Created by Антон Буков on 02.05.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import "ABBarButtonItemObserversChainIntention.h"

@interface ABBarButtonItemObserversChainIntention ()

@property (weak, nonatomic) IBOutlet ABBarButtonItemObserversChainIntention *nextObserver;

@end

@implementation ABBarButtonItemObserversChainIntention

- (IBAction)itemTriggered:(UIBarButtonItem *)item
{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.target performSelector:self.action withObject:item];
    #pragma clang diagnostic pop
    
    [self.nextObserver itemTriggered:item];
}

@end
