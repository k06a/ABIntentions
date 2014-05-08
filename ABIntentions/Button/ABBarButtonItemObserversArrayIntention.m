//
//  ABBarButtonItemMultipleObserversIntention.m
//  ABIntentionsDemo
//
//  Created by Антон Буков on 02.05.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import "ABBarButtonItemObserversArrayIntention.h"

@implementation ABBarButtonItemObserversArrayIntention

- (IBAction)itemTriggered:(UIBarButtonItem *)item
{
    for (id target in [self allTargets])
    {
        for (NSString *actionName in [self actionsForTarget:target forControlEvent:UIControlEventValueChanged])
        {
            SEL action = NSSelectorFromString(actionName);
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:action withObject:item];
            #pragma clang diagnostic pop
        }
    }
}

@end
