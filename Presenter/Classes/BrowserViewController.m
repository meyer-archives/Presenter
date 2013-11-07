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
    [self.view setMultipleTouchEnabled:YES];

    // Full-screen webview
    self.presenterWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    self.presenterWebView.delegate = self;
    self.presenterWebView.scalesPageToFit = YES; // TODO: Fix Framer metatag issue
//    self.presenterWebView.multipleTouchEnabled = NO;
    [self.view insertSubview:self.presenterWebView atIndex:0]; // lengthy version of addSubview

    [self.presenterWebView.scrollView setBounces: NO];
    
    UISwipeGestureRecognizer *upSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(upSwipeHappened:)];
    UISwipeGestureRecognizer *downSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(downSwipeHappened:)];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHappened:)];

    upSwipeGesture.numberOfTouchesRequired = 2;
    upSwipeGesture.cancelsTouchesInView = YES;
    upSwipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
    
    downSwipeGesture.numberOfTouchesRequired = 2;
    downSwipeGesture.cancelsTouchesInView = YES;
    downSwipeGesture.direction = UISwipeGestureRecognizerDirectionDown;

    panGesture.minimumNumberOfTouches = 2;
    panGesture.maximumNumberOfTouches = 4;
    panGesture.cancelsTouchesInView = YES;
    
    upSwipeGesture.delegate = self;
    downSwipeGesture.delegate = self;
    panGesture.delegate = self;
    
    [self.presenterWebView.scrollView addGestureRecognizer:upSwipeGesture];
    [self.presenterWebView.scrollView addGestureRecognizer:downSwipeGesture];
    [self.presenterWebView.scrollView addGestureRecognizer:panGesture];
    
    [self.presenterWebView addGestureRecognizer:upSwipeGesture];
    [self.presenterWebView addGestureRecognizer:downSwipeGesture];
    [self.presenterWebView addGestureRecognizer:panGesture];

    // Load URL
    NSURL *url = [NSURL URLWithString:[self tappedURL]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.presenterWebView loadRequest:req];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
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

#pragma mark - Swipe/pan detection

- (void)upSwipeHappened:(id)sender {
	NSLog(@"UP SWIPE: close");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)downSwipeHappened:(id)sender {
    NSLog(@"DOWN SWIPE: refresh");
    [[self presenterWebView] reload];
}

- (void)panHappened:(UIPanGestureRecognizer *)rec {
    CGPoint vel = [rec velocityInView:self.view];
    if(vel.y > 0){
        NSLog(@"PAN DOWN, vx, vy: %f %f", vel.x, vel.y);
    } else {
        NSLog(@"PAN UP, vx, vy: %f %f", vel.x, vel.y);
    }
}

@end