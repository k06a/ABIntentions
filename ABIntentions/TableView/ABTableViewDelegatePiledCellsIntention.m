//
//  ABTableViewDelegatePiledCellsIntention.m
//  ABIntentionsDemo
//
//  Created by Антон Буков on 11.05.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import "ABTableViewDelegatePiledCellsIntention.h"

@interface ABTableViewDelegatePiledCellsIntention () <UITableViewDelegate>

@end

@implementation ABTableViewDelegatePiledCellsIntention

#pragma mark - Table View

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (void)scrollViewDidScroll:(UITableView *)tableView
{
    void(^block)() = ^{
    
    for (NSIndexPath * ip in [[tableView indexPathsForVisibleRows]
                              sortedArrayUsingSelector:@selector(compare:)])
    {
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:ip];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        [cell.subviews.firstObject setClipsToBounds:NO];
        UIView * view = cell.contentView;
        
        //view.transform = CGAffineTransformIdentity;
        //view.frame = view.superview.bounds;
        CGRect rect = CGRectOffset([tableView rectForRowAtIndexPath:ip],
                                   -tableView.contentOffset.x,
                                   -tableView.contentOffset.y);
        
        CGFloat offset = - (CGRectGetMinY(rect) - CGRectGetMinY(tableView.frame) - tableView.contentInset.top);
        CGFloat offset2 = - (CGRectGetMaxY(tableView.frame) - CGRectGetMaxY(rect) - tableView.contentInset.bottom);
        
        offset += 8;
        offset2 += 8;
        
        CGFloat znak = 1;
        if (offset > offset2) {
            [cell.superview bringSubviewToFront:cell];
        } else {
            [cell.superview sendSubviewToBack:cell];
            offset = offset2;
            znak = -1;
        }
        
        CGFloat k1 = MIN(1,(7 + ((100 - offset) / 100))/8);
        CGFloat k2 = MAX(0,offset*0.9);
        
        //CGFloat k1 = MAX(0,MIN(1,(offset + 200)/250));
        //CGFloat k2 = MAX(0,offset);
        if (ip.row == 0 && ip.section == 0)
            NSLog(@"%f %f %f %f", offset, k1, k2, log10(MAX(1,offset)));
        view.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0,znak*k2),k1,k1);
    }
        
    };
    
    block();
    dispatch_async(dispatch_get_main_queue(), block);
    
    if ([self.nextDelegate respondsToSelector:@selector(scrollViewDidScroll:)])
        [self.nextDelegate scrollViewDidScroll:tableView];
}

#pragma mark - Message Forwarding

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector])
        return YES;
    return [self.nextDelegate respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.nextDelegate;
}

@end
