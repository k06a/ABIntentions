//
//  ABRadioCellsInTableView.m
//  Parking
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

#import <objc/runtime.h>
#import "ABTableViewDelegateRadioSelectableCellsIntention.h"

@interface ABTableViewDelegateRadioSelectableCellsIntention () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet id<UITableViewDelegate> nextDelegate;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cells;

@end

@implementation ABTableViewDelegateRadioSelectableCellsIntention

- (UITableViewCell *)selectedCell
{
    for (UITableViewCell *cell in self.cells)
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
            return cell;
    return nil;
}

- (void)setSelectedCell:(UITableViewCell *)selectedCell
{
    NSInteger index = [self.cells indexOfObject:selectedCell];
    if (index == NSNotFound)
        return;
    
    for (NSInteger i = 0; i < self.cells.count; i++)
    {
        UITableViewCell *cell = self.cells[i];
        if (i == index)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setSelectedCell:[tableView cellForRowAtIndexPath:indexPath]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.nextDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
        [self.nextDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

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
