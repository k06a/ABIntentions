//
//  ABWebViewLoadUrlIntention.m
//  Parking
//
//  Created by Антон Буков on 30.04.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import "ABWebViewLoadUrlIntention.h"

@interface ABWebViewLoadUrlIntention () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet id<UIWebViewDelegate> nextDelegate;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (strong, nonatomic) NSString *url;

@end

@implementation ABWebViewLoadUrlIntention

- (void)setWebView:(UIWebView *)webView
{
    _webView = webView;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    });
}

#pragma mark - Web View

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.activityView.hidden = NO;
    if ([self.nextDelegate respondsToSelector:@selector(webViewDidStartLoad:)])
        [self.nextDelegate webViewDidStartLoad:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.activityView.hidden = YES;
    if ([self.nextDelegate respondsToSelector:@selector(webViewDidFinishLoad:)])
        [self.nextDelegate webViewDidFinishLoad:webView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    if ([self.nextDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)])
        [self.nextDelegate webView:webView didFailLoadWithError:error];
}

#pragma mark - Message Forwarding

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
