//
//  LinkListViewController.m
//  Presenter
//
//  Created by Mike Meyer on 05/11/2013.
//  Copyright (c) 2013 Mike Meyer. All rights reserved.
//

#import "LinkListViewController.h"
#import "BrowserViewController.h"

@interface LinkListViewController ()
{

    IBOutlet UITableView *LinkListTableView;

}
@end

@implementation LinkListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"LinkList viewDidLoad");

    [super viewDidLoad];
    self.linkListData = [[NSMutableArray alloc] initWithObjects:@"http://demotron.dev", @"http://google.com", @"http://framerjs.com", nil];
   
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
 
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.linkListData count];
}

// Populate individual cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LinkListCell"];
    UILabel *labelName = (UILabel *)[cell viewWithTag:100];

    [labelName setText:[self.linkListData objectAtIndex:[indexPath row]]];
    
    return cell;
}

- (void) tableView:(UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath{
    NSLog(@"Tapped cell %d", [indexPath row]);
    self.currentURL = [self.linkListData objectAtIndex:[indexPath row]];
    
    [self performSegueWithIdentifier:@"showBrowser" sender:self];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
//}

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"SEGWAI: %@", [segue identifier]);
    NSLog(@"SENDER: %@", sender);

    if ([segue.identifier isEqualToString:@"showBrowser"])
    {
        BrowserViewController *bvc = (BrowserViewController *)segue.destinationViewController;
        bvc.tappedURL = self.currentURL;
    }
    
    [segue destinationViewController];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
