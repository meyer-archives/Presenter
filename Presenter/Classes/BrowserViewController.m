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
    self.presenterWebView.delegate = self;
    self.presenterWebView.scalesPageToFit = YES; // TODO: Fix Framer metatag issue
    self.presenterWebView.multipleTouchEnabled = NO;
    [self.view insertSubview:self.presenterWebView atIndex:0]; // lengthy version of addSubview

    [self.presenterWebView.scrollView setBounces: NO];
    
    UISwipeGestureRecognizer *upSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upSwipeHappened:)];
    UISwipeGestureRecognizer *downSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downSwipeHappened:)];

    upSwipeGesture.numberOfTouchesRequired = 2;
    upSwipeGesture.cancelsTouchesInView = YES;
    upSwipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
    
    downSwipeGesture.numberOfTouchesRequired = 2;
    downSwipeGesture.cancelsTouchesInView = YES;
    downSwipeGesture.direction = UISwipeGestureRecognizerDirectionDown;

    [self.presenterWebView.scrollView addGestureRecognizer:upSwipeGesture];
    [self.presenterWebView.scrollView addGestureRecognizer:downSwipeGesture];
    
//    [self.presenterWebView addGestureRecognizer:upSwipeGesture];
//    [self.presenterWebView addGestureRecognizer:downSwipeGesture];

    // Load URL
    NSURL *url = [NSURL URLWithString:[self tappedURL]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.presenterWebView loadRequest:req];
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

-(void)upSwipeHappened:(id)sender {
	NSLog(@"UP SWIPE: close");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)downSwipeHappened:(id)sender {
    NSLog(@"DOWN SWIPE: refresh");
    [[self presenterWebView] reload];
}

@end