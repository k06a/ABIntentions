//
//  ABWebViewLoadUrlIntention.h
//  Parking
//
//  Created by Антон Буков on 30.04.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABWebViewActionsIntention : NSObject

@property (weak, nonatomic) IBOutlet id<UIWebViewDelegate> nextDelegate;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *activityView;
@property (strong, nonatomic) NSString *url;

@property (strong, nonatomic) IBOutletCollection(UIControl) NSArray *goBackControls;
@property (strong, nonatomic) IBOutletCollection(UIControl) NSArray *goForwardControls;

- (IBAction)goBack:(id)sender;
- (IBAction)goForward:(id)sender;

@end
