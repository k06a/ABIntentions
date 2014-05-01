//
//  ABBarButtonItemRadioSelectableIntention.m
//  ABIntentionsDemo
//
//  Created by Антон Буков on 02.05.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import "ABBarButtonItemRadioSelectableIntention.h"

@interface ABBarButtonItemRadioSelectableIntention ()

@property (strong, nonatomic) IBOutletCollection(UIBarButtonItem) NSArray *items;

@property (assign, nonatomic) NSInteger selectedItemIndex;

@end

@implementation ABBarButtonItemRadioSelectableIntention

- (IBAction)itemTiggered:(UIBarButtonItem *)item
{
    UIBarButtonItem *prev = self.items[self.selectedItemIndex];
    if (prev == item)
        return;

    self.selectedItemIndex = [self.items indexOfObject:item];
    for (NSNumber *value in @[@(UIControlStateNormal),
                              @(UIControlStateSelected),
                              @(UIControlStateHighlighted),
                              @(UIControlStateDisabled)])
    {
        UIControlState state = [value unsignedIntegerValue];
        NSDictionary *itemAttrs = [item titleTextAttributesForState:state];
        NSDictionary *prevAttrs = [prev titleTextAttributesForState:state];
        [item setTitleTextAttributes:prevAttrs forState:state];
        [prev setTitleTextAttributes:itemAttrs forState:state];
    }
    
    UIColor *itemTintColor = item.tintColor;
    UIColor *prevTintColor = prev.tintColor;
    item.tintColor = prevTintColor;
    prev.tintColor = itemTintColor;
}

@end
