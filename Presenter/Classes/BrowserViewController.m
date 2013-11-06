//
//  BrowserViewController.m
//  Presenter
//
//  Created by Mike Meyer on 05/11/2013.
//  Copyright (c) 2013 Mike Meyer. All rights reserved.
//

#import "BrowserViewController.h"

@interface BrowserViewController ()

@end

@implementation BrowserViewController

// TODO: Trigger this action on three-finger up swipe
- (IBAction)goBackToList:(id)sender
{
    NSLog(@"Dismiss BrowserViewController");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)refreshBrowser:(id)sender
{
    [[self presenterWebView] reload];
    NSLog(@"refresh button tapped");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Browser viewDidLoad -- %@", [self tappedURL]);

    // Full-screen webview
    self.presenterWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    self.presenterWebView.scalesPageToFit = YES; // TODO: Fix Framer metatag issue
    self.presenterWebView.multipleTouchEnabled = NO;
    [self.view insertSubview:self.presenterWebView atIndex:0]; // lengthy version of addSubview
    
    // Pan gesture
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
	[panRecognizer setMinimumNumberOfTouches:2];
	[panRecognizer setMaximumNumberOfTouches:3];
    self.presenterWebView.delegate = self;
    [[self.presenterWebView scrollView] setBounces: NO];
	[self.presenterWebView addGestureRecognizer:panRecognizer];
   
    // Load URL
    NSURL *url = [NSURL URLWithString:[self tappedURL]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [[self presenterWebView] loadRequest:req];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webviewDidFinishLoading");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"webview didFailLoadWithError");
}

-(void)move:(id)sender {
	NSLog(@"See a move gesture");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
