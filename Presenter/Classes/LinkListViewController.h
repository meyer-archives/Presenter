//
//  LinkListViewController.h
//  Presenter
//
//  Created by Mike Meyer on 05/11/2013.
//  Copyright (c) 2013 Mike Meyer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinkListViewController : UITableViewController <UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) NSMutableArray *linkListData;
@property (strong, nonatomic) NSString *currentURL;

@end
