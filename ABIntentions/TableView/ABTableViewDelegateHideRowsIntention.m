//
//  ABTableViewDataSourceHideRowOnActionIntention.m
//  ABIntentionsDemo
//
//  Created by Антон Буков on 28.04.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import "ABTableViewDelegateHideRowsIntention.h"

@interface ABTableViewDelegateHideRowsIntention ()

@property (nonatomic, assign) BOOL isCellsHidden;

@end

@implementation ABTableViewDelegateHideRowsIntention

- (void)extractIndexPathsFromCellsForced:(BOOL)forced
{
    if (_indexPaths.count > 0 && !forced)
        return;
    if (self.cells == nil)
        return;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger s = 0; s < self.tableView.numberOfSections; s++)
    {
        NSInteger rows = [self.tableView.dataSource tableView:self.tableView numberOfRowsInSection:s];
        for (NSInteger r = 0; r < rows; r++)
        {
            NSIndexPath *ip = [NSIndexPath indexPathForRow:r inSection:s];
            UITableViewCell *cell = [self.tableView.dataSource tableView:self.tableView cellForRowAtIndexPath:ip];
            if ([self.cells containsObject:cell])
                [arr addObject:ip];
        }
    }
    self.indexPaths = [arr sortedArrayUsingSelector:@selector(compare:)];
}

- (void)setCells:(NSArray *)cells
{
    _cells = cells;
    [self extractIndexPathsFromCellsForced:YES];
}

- (void)setTableView:(UITableView *)tableView
{
    _tableView = tableView;
    if (self.indexPaths == nil)
        [self extractIndexPathsFromCellsForced:NO];
}

- (void)setNextDelegate:(id<UITableViewDelegate>)nextDelegate
{
    _nextDelegate = nextDelegate;
    if (self.indexPaths == nil)
        [self extractIndexPathsFromCellsForced:NO];
}

- (NSArray *)indexPaths
{
    if (_indexPaths.count == 0 && self.cells.count > 0)
        [self extractIndexPathsFromCellsForced:NO];
    return _indexPaths;
}

- (CGFloat)tableHeight
{
    return self.tableView.bounds.size.height;
    //return [self.tableView sizeThatFits:CGSizeMake(self.tableView.frame.size.width, HUGE_VALF)].height;
}

- (IBAction)toggleVisibilityOfCells:(id)sender
{
    CGPoint point = self.tableView.bounds.origin;
    
    [self.tableView beginUpdates];
    self.isCellsHidden = !self.isCellsHidden;
    if ([self.nextDelegate respondsToSelector:@selector(scrollViewDidScroll:)])
        [self.nextDelegate scrollViewDidScroll:self.tableView];
    [self.tableView endUpdates];
    [UIView animateWithDuration:0.25 animations:^{
        for (NSIndexPath *indexPath in self.indexPaths) {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.contentView.alpha = (self.isCellsHidden ? 0.0 : 1.0);
        }
    }];
    /*
    self.tableView.contentOffset = point;
    CGFloat y = MAX(-self.tableView.contentInset.top,MIN(point.y,[self tableHeight] - self.tableView.bounds.size.height));
    [self.tableView setContentOffset:CGPointMake(point.x,y) animated:YES];*/
}

- (IBAction)hideCells:(id)sender
{
    if (!self.isCellsHidden)
        [self toggleVisibilityOfCells:sender];
}

- (IBAction)showCells:(id)sender
{
    if (self.isCellsHidden)
        [self toggleVisibilityOfCells:sender];
}

#pragma mark - Table View

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isCellsHidden && [self.indexPaths containsObject:indexPath])
        return 0;
    if ([self.nextDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)])
        return [self.nextDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
    return self.tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isCellsHidden && [self.indexPaths containsObject:indexPath])
        return 0;
    if ([self.nextDelegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)])
        return [self.nextDelegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.indexPaths containsObject:indexPath])
        cell.contentView.alpha = self.isCellsHidden ? 0.0 : 1.0;
    if ([self.nextDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)])
        [self.nextDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
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
