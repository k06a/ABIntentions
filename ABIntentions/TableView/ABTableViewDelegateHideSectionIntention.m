//
//  ABTableViewDelegateHideSectionIntention.m
//  ABIntentionsDemo
//
//  Created by Антон Буков on 07.05.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import "ABTableViewDelegateHideSectionIntention.h"

@interface ABTableViewDelegateHideSectionIntention () <UITableViewDelegate>

@property (assign, nonatomic) BOOL isSectionHidden;

@end

@implementation ABTableViewDelegateHideSectionIntention

- (NSArray *)cells
{
    NSMutableArray *arr = [NSMutableArray array];
    NSInteger rows = [self.tableView.dataSource tableView:self.tableView numberOfRowsInSection:self.section.integerValue];
    for (NSInteger r = 0; r < rows; r++)
    {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:r inSection:self.section.integerValue];
        UITableViewCell *cell = [self.tableView.dataSource tableView:self.tableView cellForRowAtIndexPath:ip];
        [arr addObject:cell];
    }
    return arr;
}

- (CGFloat)tableHeight
{
    return [self.tableView sizeThatFits:CGSizeMake(self.tableView.frame.size.width, HUGE_VALF)].height;
}

- (IBAction)toggleVisibilityOfSection:(id)sender
{
    CGPoint point = self.tableView.bounds.origin;
    
    [self.tableView beginUpdates];
    self.isSectionHidden = !self.isSectionHidden;
    UIView *headerView = [self.tableView headerViewForSection:self.section.integerValue];
    UIView *footerView = [self.tableView footerViewForSection:self.section.integerValue];
    if (!self.isSectionHidden) {
        headerView.hidden = NO;
        footerView.hidden = NO;
    }
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat alpha = (self.isSectionHidden ? 0.0 : 1.0);
        for (UITableViewCell *cell in [self cells])
            cell.contentView.alpha = alpha;
        headerView.alpha = alpha;
        footerView.alpha = alpha;
    } completion:^(BOOL finished) {
        if (self.isSectionHidden) {
            headerView.hidden = YES;
            footerView.hidden = YES;
        }
    }];
    [self.tableView endUpdates];
    
    self.tableView.contentOffset = point;
    CGFloat y = MAX(-self.tableView.contentInset.top,MIN(point.y,[self tableHeight] - self.tableView.bounds.size.height));
    [self.tableView setContentOffset:CGPointMake(point.x,y) animated:YES];
}

- (IBAction)hideSection:(id)sender
{
    if (!self.isSectionHidden)
        [self toggleVisibilityOfSection:sender];
}

- (IBAction)showSection:(id)sender
{
    if (self.isSectionHidden)
        [self toggleVisibilityOfSection:sender];
}

#pragma mark - Table View
/*
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    if (self.isSectionHidden && section == self.section.integerValue)
        return 0;
    if ([self.nextDelegate respondsToSelector:@selector(tableView:estimatedHeightForHeaderInSection:)])
        return [self.nextDelegate tableView:tableView estimatedHeightForHeaderInSection:section];
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSectionHidden && indexPath.section == self.section.integerValue)
        return 0;
    if ([self.nextDelegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)])
        return [self.nextDelegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    if (self.isSectionHidden && section == self.section.integerValue)
        return 0;
    if ([self.nextDelegate respondsToSelector:@selector(tableView:estimatedHeightForFooterInSection:)])
        return [self.nextDelegate tableView:tableView estimatedHeightForFooterInSection:section];
    return UITableViewAutomaticDimension;
}
*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isSectionHidden && section == self.section.integerValue)
        return 0;
    if ([self.nextDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)])
        return [self.nextDelegate tableView:tableView heightForHeaderInSection:section];
    return self.tableView.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSectionHidden && indexPath.section == self.section.integerValue)
        return 0;
    if ([self.nextDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)])
        return [self.nextDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
    return self.tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.isSectionHidden && section == self.section.integerValue)
        return 0;
    if ([self.nextDelegate respondsToSelector:@selector(tableView:heightForFooterInSection:)])
        return [self.nextDelegate tableView:tableView heightForFooterInSection:section];
    return self.tableView.sectionFooterHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (self.isSectionHidden && section == self.section.integerValue)
        view.hidden = YES;
    if ([self.nextDelegate respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)])
        [self.nextDelegate tableView:tableView willDisplayHeaderView:view forSection:section];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    if (self.isSectionHidden && section == self.section.integerValue)
        view.hidden = YES;
    if ([self.nextDelegate respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)])
        [self.nextDelegate tableView:tableView willDisplayFooterView:view forSection:section];
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
