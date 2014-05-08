//
//  ABTableViewDelegateHideSectionIntention.h
//  ABIntentionsDemo
//
//  Created by Антон Буков on 07.05.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABTableViewDelegateHideSectionIntention : NSObject

@property (weak, nonatomic) IBOutlet id<UITableViewDelegate> nextDelegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSNumber *section;

@property (readonly, nonatomic) BOOL isSectionHidden;

- (IBAction)toggleVisibilityOfSection:(id)sender;
- (IBAction)hideSection:(id)sender;
- (IBAction)showSection:(id)sender;

@end
