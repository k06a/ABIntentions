//
//  ABPageViewControllerDataSourcePagesIntention.h
//  ABIntentionsDemo
//
//  Created by Антон Буков on 18.05.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABPageViewControllerDataSourceStaticPagesIntention : NSObject

@property (weak, nonatomic) IBOutlet id<UIPageViewControllerDataSource> nextDataSource;
@property (weak, nonatomic) IBOutlet UIPageViewController *pageController;

@property (strong, nonatomic) NSString *page1;
@property (strong, nonatomic) NSString *page2;
@property (strong, nonatomic) NSString *page3;
@property (strong, nonatomic) NSString *page4;
@property (strong, nonatomic) NSString *page5;
@property (strong, nonatomic) NSString *page6;
@property (strong, nonatomic) NSString *page7;
@property (strong, nonatomic) NSString *page8;
@property (strong, nonatomic) NSString *page9;

- (IBAction)nextPage:(id)sender;
- (IBAction)prevPage:(id)sender;

@property (strong, nonatomic) NSNumber *initialPageIndex;
@property (assign, nonatomic) NSInteger currentPageIndex;

@end
