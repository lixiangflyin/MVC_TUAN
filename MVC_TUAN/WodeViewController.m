//
//  WodeViewController.m
//  MVC_TUAN
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "WodeViewController.h"

@interface WodeViewController ()

@end

@implementation WodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"我的";
    self.tableView.frame = CGRectMake(50, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    self.tableView.tableHeaderView = _headView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 1;
    }
    if(section == 1){
        return 3;
    }
    if(section == 2){
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    
    // Configure the cell...
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"每日推荐";
                    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:16];
                    cell.detailTextLabel.font = cell.textLabel.font = [UIFont fontWithName:@"Arial" size:16];
                    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                    break;
                }
                    
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"代金券";
                    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:16];
                    cell.detailTextLabel.font = cell.textLabel.font = [UIFont fontWithName:@"Arial" size:16];
                    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                    break;
                }
                    
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"待付款订单";
                    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:16];
                    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                    break;
                }
                case 1:
                {
                    cell.textLabel.text = @"已付款订单";
                    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:16];
                    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                    break;
                }
                case 2:
                {
                    cell.textLabel.text = @"抽奖单";
                    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:16];
                    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                    break;
                }
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
