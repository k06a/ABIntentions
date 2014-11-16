//
//  ABTextFieldBecameActiveOnLoadIntention.h
//  ABIntentionsDemo
//
//  Created by Антон Буков on 11.08.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABTextFieldBecameActiveOnLoadIntention : NSObject

@property (nonatomic, strong) NSNumber *delay;
@property (nonatomic, weak) IBOutlet UIResponder *responder;

@end
