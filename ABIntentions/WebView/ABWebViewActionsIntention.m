//
//  ABWebViewLoadUrlIntention.m
//  Parking
//
//  Created by Антон Буков on 30.04.14.
//  Copyright (c) 2014 Codeless Solutions. All rights reserved.
//

#import "ABWebViewActionsIntention.h"

@interface ABWebViewActionsIntention () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet id<UIWebViewDelegate> nextDelegate;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *activityView;
@property (strong, nonatomic) NSString *url;

@property (strong, nonatomic) IBOutletCollection(UIControl) NSArray *goBackControls;
@property (strong, nonatomic) IBOutletCollection(UIControl) NSArray *goForwardControls;

@end

@implementation ABWebViewActionsIntention

- (void)setWebView:(UIWebView *)webView
{
    _webView = webView;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
        [self updateControlsState];
    });
}

- (void)setGoBackControls:(NSArray *)goBackControls
{
    _goBackControls = goBackControls;
    [self updateControlsState];
}

- (void)setGoForwardControls:(NSArray *)goForwardControls
{
    _goForwardControls = goForwardControls;
    [self updateControlsState];
}

- (void)updateControlsState
{
    for (UIControl *control in self.goBackControls)
        control.enabled = [self.webView canGoBack];
    for (UIControl *control in self.goForwardControls)
        control.enabled = [self.webView canGoForward];
}

- (IBAction)goBack:(id)sender
{
    [self.webView goBack];
    [self updateControlsState];
}

- (IBAction)goForward:(id)sender
{
    [self.webView goForward];
    [self updateControlsState];
}

#pragma mark - Web View

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.activityView.hidden = NO;
    [self updateControlsState];
    if ([self.nextDelegate respondsToSelector:@selector(webViewDidStartLoad:)])
        [self.nextDelegate webViewDidStartLoad:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.activityView.hidden = YES;
    [self updateControlsState];
    if ([self.nextDelegate respondsToSelector:@selector(webViewDidFinishLoad:)])
        [self.nextDelegate webViewDidFinishLoad:webView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self updateControlsState];
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
