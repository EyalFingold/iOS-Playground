//
//  LoadTestsTableViewController.m
//  SRL.Objective-C
//
//  Created by Eyal Fingold on 1/25/15.
//  Copyright (c) 2015 Eyal Fingold. All rights reserved.
//

#import "LoadTestsTableViewController.h"
#import "DetailLoadTestViewController.h"
#import "LoadTestsModel.h"

@interface LoadTestsTableViewController ()
//theDataModel

@end

@implementation LoadTestsTableViewController



- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isUpdatingData = false;
    // Do any additional setup after loading the view, typically from a nib.
    /*
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
     */
    
    // Registering notification message RefreshLoadTests and hooking into refreshTableWithNotification, so to be able to get outside notifications for data update.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableWithNotification:) name:@"RefreshLoadTests" object:nil];
    
 
    
    self.theDataModel = [[LoadTestsModel alloc] init];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self
        action:@selector(refreshView:)
        forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    [[self theDataModel] updateData];

}

- (void)refreshTableWithNotification:(NSNotification *)notification
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//updating data from server
-(void)refreshView:(UIRefreshControl *)refresh {

    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];

    //TODO:hook to datamodel refresh
    [[self theDataModel] updateData];
 
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@",
    [formatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    [refresh endRefreshing];
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.theDataModel.LoadTests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *object = self.theDataModel.LoadTests[indexPath.row];
    cell.textLabel.text = object[@"name"];
    [cell setAccessoryType:(UITableViewCellAccessoryDisclosureIndicator)];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //[self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
