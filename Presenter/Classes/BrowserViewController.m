//
//  BrowserViewController.m
//  Presenter
//
//  Created by Mike Meyer on 05/11/2013.
//  Copyright (c) 2013 Mike Meyer. All rights reserved.
//

#import "BrowserViewController.h"

@interface BrowserViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *presenterWebView;
@property (nonatomic, strong) NSString *tappedURL;

@end

@implementation BrowserViewController

// Close browser
// TODO: Trigger this action on three-finger up swipe
- (IBAction)goBackToList:(id)sender{
    NSLog(@"Dismiss BrowserViewController");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"Browser viewDidLoad -- %@", [self tappedURL]);

    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];

    // Load URL
    // TODO: Load from selected URL in LinkListTableView
    NSURL *url = [NSURL URLWithString:[self tappedURL]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    [[self presenterWebView] loadRequest:req];

    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
