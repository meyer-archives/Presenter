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
- (IBAction)goBackToList:(id)sender{
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

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Browser viewDidLoad -- %@", [self tappedURL]);

    // Load URL
    NSURL *url = [NSURL URLWithString:[self tappedURL]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [[self presenterWebView] loadRequest:req];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
