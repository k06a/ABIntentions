//
//  ABTableViewDelegatePiledCellsIntention.h
//  ABIntentionsDemo
//
//  Created by Антон Буков on 11.05.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABTableViewDelegatePiledCellsIntention : NSObject

@property (weak, nonatomic) IBOutlet id<UITableViewDelegate> nextDelegate;

@end
