//
//  ABTableViewDelegateHideRowsIntention+Switch.m
//  Lookus
//
//  Created by Алексей Артемьев on 24.02.15.
//  Copyright (c) 2015 Алексей Артемьев. All rights reserved.
//

#import "ABTableViewDelegateHideRowsIntention+Switch.h"

@implementation ABTableViewDelegateHideRowsIntention (Switch)

@dynamic isCellsHidden;

- (IBAction)switchVisibilityOfCells:(UISwitch *)sender
{
    if (self.isCellsHidden == !sender.isOn) return;
    [self toggleVisibilityOfCells:sender];
}

@end
