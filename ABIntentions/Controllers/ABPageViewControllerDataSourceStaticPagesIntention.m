//
//  ABPageViewControllerDataSourcePagesIntention.m
//  ABIntentionsDemo
//
//  Created by Антон Буков on 18.05.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import "ABPageViewControllerDataSourceStaticPagesIntention.h"

@interface ABPageViewControllerDataSourceStaticPagesIntention () <UIPageViewControllerDataSource>

@property (strong, nonatomic) NSArray *pages;
@property (strong, nonatomic) NSMutableDictionary *viewControllers;
@property (strong, nonatomic) NSMutableDictionary *pagesLoadedOnce;

@end

@implementation ABPageViewControllerDataSourceStaticPagesIntention

- (NSArray *)pages
{
    return [@[self.page1 ?: @"",
              self.page2 ?: @"",
              self.page3 ?: @"",
              self.page4 ?: @"",
              self.page5 ?: @"",
              self.page6 ?: @"",
              self.page7 ?: @"",
              self.page8 ?: @"",
              self.page9 ?: @"",
              ] filteredArrayUsingPredicate:
            [NSPredicate predicateWithBlock:^BOOL(NSString *a, NSDictionary *bindings) {
                return (a.length > 0);
            }]];
}

- (NSMutableDictionary *)viewControllers
{
    if (_viewControllers == nil)
        _viewControllers = [NSMutableDictionary dictionary];
    return _viewControllers;
}

- (NSMutableDictionary *)pagesLoadedOnce
{
    if (_pagesLoadedOnce == nil)
        _pagesLoadedOnce = [NSMutableDictionary dictionary];
    return _pagesLoadedOnce;
}

- (void)setPageController:(UIPageViewController *)pageController
{
    _pageController = pageController;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *viewController = [self viewControllerWithIdentifier:self.pages[self.initialPageIndex.integerValue]];
        [_pageController setViewControllers:@[viewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    });
}

#pragma mark - Common Methods

- (NSInteger)indexOfViewController:(UIViewController *)viewController
{
    NSValue *key = [NSValue valueWithPointer:(__bridge const void *)(viewController)];
    return [self.pages indexOfObject:self.viewControllers[key]];
}

- (UIViewController *)viewControllerWithIdentifier:(NSString *)identifier
{
    if (self.loadPagesOnce && self.pagesLoadedOnce[identifier])
        return self.pagesLoadedOnce[identifier];
    UIViewController *viewController = [self.pageController.storyboard instantiateViewControllerWithIdentifier:identifier];
    NSValue *key = [NSValue valueWithPointer:(__bridge const void *)(viewController)];
    self.viewControllers[key] = identifier;
    if (self.loadPagesOnce)
        self.pagesLoadedOnce[identifier] = viewController;
    return viewController;
}

- (void)setViewController:(UIViewController *)viewController direction:(UIPageViewControllerNavigationDirection)direction animated:(BOOL)animated
{
    [self.pageController setViewControllers:@[viewController]
                                  direction:direction
                                   animated:animated
                                 completion:nil];
}


#pragma mark - Page View Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfViewController:viewController];
    if (index == self.pages.count - 1)
        return nil;
    return [self viewControllerWithIdentifier:self.pages[index + 1]];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfViewController:viewController];
    if (index == 0)
        return nil;
    return [self viewControllerWithIdentifier:self.pages[index - 1]];
}

#pragma mark - Next and Prev Pages

- (IBAction)nextPage:(id)sender
{
    UIViewController *viewController = [self pageViewController:self.pageController viewControllerAfterViewController:self.pageController.viewControllers.firstObject];
    if (!viewController)
        return;
    [self setViewController:viewController direction:(UIPageViewControllerNavigationDirectionForward) animated:YES];
}

- (IBAction)prevPage:(id)sender
{
    UIViewController *viewController = [self pageViewController:self.pageController viewControllerBeforeViewController:self.pageController.viewControllers.firstObject];
    if (!viewController)
        return;
    [self setViewController:viewController direction:(UIPageViewControllerNavigationDirectionReverse) animated:YES];
}

- (NSInteger)currentPageIndex
{
    return [self indexOfViewController:self.pageController.viewControllers.firstObject];
}

- (void)setCurrentPageIndex:(NSInteger)currentPageIndex
{
    [self setCurrentPageIndex:currentPageIndex animated:YES];
}

- (void)setCurrentPageIndex:(NSInteger)currentPageIndex animated:(BOOL)animated
{
    UIPageViewControllerNavigationDirection direction;
    if (self.currentPageIndex < currentPageIndex)
        direction = UIPageViewControllerNavigationDirectionForward;
    else
        direction = UIPageViewControllerNavigationDirectionReverse;
    
    UIViewController *viewController = [self viewControllerWithIdentifier:self.pages[currentPageIndex]];
    [self setViewController:viewController direction:direction animated:animated];
}

#pragma mark - Message Forwarding

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector])
        return YES;
    return [self.nextDataSource respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.nextDataSource;
}

@end
