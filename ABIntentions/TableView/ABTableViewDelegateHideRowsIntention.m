//
//  ABTableViewDataSourceHideRowOnActionIntention.m
//  ABIntentionsDemo
//
//  Created by Антон Буков on 28.04.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import "ABTableViewDelegateHideRowsIntention.h"

@interface ABTableViewDelegateHideRowsIntention () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet id<UITableViewDelegate> nextDelegate;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cells;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) BOOL isCellsHidden;

@end

@implementation ABTableViewDelegateHideRowsIntention

- (NSArray *)indexPaths
{
    NSMutableArray *arr = [NSMutableArray array];
    NSInteger sections = 1;
    if ([self.tableView.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)])
        sections = [self.tableView.dataSource numberOfSectionsInTableView:self.tableView];
    for (NSInteger s = 0; s < sections; s++)
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
    return [arr sortedArrayUsingSelector:@selector(compare:)];
}

- (CGFloat)tableHeight
{
    return [self.tableView sizeThatFits:CGSizeMake(self.tableView.frame.size.width, HUGE_VALF)].height;
}

- (IBAction)toggleVisibilityOfCells:(id)sender
{
    CGPoint point = self.tableView.bounds.origin;
    
    [self.tableView beginUpdates];
    self.isCellsHidden = !self.isCellsHidden;
    [UIView animateWithDuration:0.25 animations:^{
        for (UITableViewCell *cell in self.cells)
            cell.contentView.alpha = (self.isCellsHidden ? 0.0 : 1.0);
    }];
    [self.tableView endUpdates];
    
    self.tableView.contentOffset = point;
    CGFloat y = MAX(-self.tableView.contentInset.top,MIN(point.y,[self tableHeight] - self.tableView.bounds.size.height));
    [self.tableView setContentOffset:CGPointMake(point.x,y) animated:YES];
}

#pragma mark - Table View

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isCellsHidden && [[self indexPaths] containsObject:indexPath])
        return 0;
    if ([self.nextDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)])
        return [self.nextDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
    return self.tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isCellsHidden && [[self indexPaths] containsObject:indexPath])
        return 0;
    if ([self.nextDelegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)])
        return [self.nextDelegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    return UITableViewAutomaticDimension;
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
