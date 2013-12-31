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

// TODO: Remove this maybe?
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
    self.presenterWebView.scalesPageToFit = NO; // TODO: Fix Framer metatag issue
    self.presenterWebView.multipleTouchEnabled = NO;
    [self.presenterWebView sizeToFit];
    
    [self.view insertSubview:self.presenterWebView atIndex:0]; // lengthy version of addSubview

    [self.presenterWebView.scrollView setBounces: NO];
    [self.presenterWebView.scrollView setMultipleTouchEnabled:NO];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHappened:)];

    panGesture.minimumNumberOfTouches = 2;
    panGesture.maximumNumberOfTouches = 10;
    panGesture.cancelsTouchesInView = YES;
    panGesture.delegate = self;

    [self.view addGestureRecognizer:panGesture];

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
//    self.presenterWebView.alpha = 0;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webviewDidFinishLoading");
//    self.presenterWebView.alpha = 0;

    if (!webView.loading) {
        [webView sizeToFit];
//        [UIView animateWithDuration: 0.3f
//                              delay: 0.2f
//                            options: UIViewAnimationOptionCurveEaseInOut
//                         animations:^{
//                             self.presenterWebView.alpha = 1.0;
//                         }
//                         completion:nil];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"webview didFailLoadWithError");
}

#pragma mark - Swipe/pan detection

- (void)panHappened:(UIPanGestureRecognizer *)recognizer {
    CGPoint velocity = [recognizer velocityInView:self.view];
    CGPoint translation = [recognizer translationInView:self.view];
//    CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));

    // Increment view offset
    recognizer.view.center = CGPointMake(recognizer.view.center.x, //recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];

//    CGFloat slideMult = magnitude / 200;

//    float slideFactor = 0.1 * slideMult; // Increase for more slide

    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            NSLog(@"Started pan gesture: %f", recognizer.view.frame.origin.y);

            [self.presenterWebView setUserInteractionEnabled:NO];
            
            [UIView animateWithDuration: 0.2f
                                  delay: 0
                                options: UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 self.presenterWebView.alpha = 0.4;
                             }
                             completion:nil];
        }
            break;
        case UIGestureRecognizerStateChanged:{
//            NSLog(@"Pan gesture changed: %f", recognizer.view.center.y + translation.y);
        }
            break;
        case UIGestureRecognizerStateCancelled:{
            NSLog(@"Pan gesture cancelled");
        }
        break;
        case UIGestureRecognizerStateEnded:{
            NSLog(@"Ended pan gesture: %f", recognizer.view.frame.origin.y);

            [self.presenterWebView setUserInteractionEnabled:YES];
            
            if(velocity.y < 0){
                // TODO: Check pan distance
                NSLog(@"UP");
                if (recognizer.view.frame.origin.y < -100) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                    break;
                } else {
                    NSLog(@"Not enough!");
                }
            } else {
                NSLog(@"DOWN");

                if (recognizer.view.frame.origin.y > 100) {
                    [[self presenterWebView] performSelector:@selector(reload) withObject:nil afterDelay:0.6f];
                } else {
                    NSLog(@"Not enough!");
                }
            }
           
            // Spring back
            [UIView animateWithDuration: 0.2f
                                  delay: 0
                                options: UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.presenterWebView.alpha = 1.0;
                                 CGPoint finalPoint = CGPointMake(160, 284);
                                 recognizer.view.center = finalPoint; }
                             completion:nil];
        }
        break;
        default:{
            NSLog(@"Unhandled state: %d", recognizer.state);
        }
    }
}

@end