//
//  BrowserViewController.h
//  Presenter
//
//  Created by Mike Meyer on 05/11/2013.
//  Copyright (c) 2013 Mike Meyer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowserViewController : UIViewController{}

@property (weak, nonatomic) IBOutlet UIWebView *presenterWebView;
@property (nonatomic, strong) NSString *tappedURL;

- (IBAction)goBackToList:(id)sender;
- (IBAction)refreshBrowser:(id)sender;

@end
