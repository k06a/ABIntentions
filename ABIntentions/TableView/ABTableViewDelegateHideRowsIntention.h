//
//  ABTableViewDataSourceHideRowOnActionIntention.h
//  ABIntentionsDemo
//
//  Created by Антон Буков on 28.04.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABTableViewDelegateHideRowsIntention : NSObject

@property (weak, nonatomic) IBOutlet id<UITableViewDelegate> nextDelegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cells;

@property (readonly, nonatomic) BOOL isCellsHidden;

- (IBAction)toggleVisibilityOfCells:(id)sender;
- (IBAction)hideCells:(id)sender;
- (IBAction)showCells:(id)sender;

@end
