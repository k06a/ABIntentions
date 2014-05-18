//
//  ABPageViewControllerDataSourcePagesIntention.m
//  ABIntentionsDemo
//
//  Created by Антон Буков on 18.05.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import "ABPageViewControllerDataSourcePagesIntention.h"

@interface ABPageViewControllerDataSourcePagesIntention () <UIPageViewControllerDataSource>

@property (strong, nonatomic) NSArray *pages;
@property (strong, nonatomic) NSMutableDictionary *viewControllers;

@end

@implementation ABPageViewControllerDataSourcePagesIntention

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

- (void)setPageController:(UIPageViewController *)pageController
{
    _pageController = pageController;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *viewController = [self viewControllerWithIdentifier:self.pages[0] storyboard:pageController.storyboard];
        [_pageController setViewControllers:@[viewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    });
}

- (NSInteger)indexOfViewController:(UIViewController *)viewController
{
    NSValue *key = [NSValue valueWithPointer:(__bridge const void *)(viewController)];
    return [self.pages indexOfObject:self.viewControllers[key]];
}

- (UIViewController *)viewControllerWithIdentifier:(NSString *)identifier storyboard:(UIStoryboard *)storyboard
{
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    NSValue *key = [NSValue valueWithPointer:(__bridge const void *)(viewController)];
    self.viewControllers[key] = identifier;
    return viewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfViewController:viewController];
    if (index == self.pages.count - 1)
        return nil;
    return [self viewControllerWithIdentifier:self.pages[index + 1] storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfViewController:viewController];
    if (index == 0)
        return nil;
    return [self viewControllerWithIdentifier:self.pages[index - 1] storyboard:viewController.storyboard];
}

@end
