//
//  ABTableViewDataSourceHideRowOnActionIntention.h
//  ABIntentionsDemo
//
//  Created by Антон Буков on 28.04.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABTableViewDelegateHideRowsIntention : NSObject <UITableViewDelegate>

@property (nonatomic, weak) IBOutlet id<UITableViewDelegate> nextDelegate;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutletCollection(UITableViewCell) NSArray *cells;

@property (nonatomic, strong) NSArray *indexPaths;

@property (nonatomic, readonly) BOOL isCellsHidden;

- (IBAction)toggleVisibilityOfCells:(id)sender;
- (IBAction)hideCells:(id)sender;
- (IBAction)showCells:(id)sender;

@end
