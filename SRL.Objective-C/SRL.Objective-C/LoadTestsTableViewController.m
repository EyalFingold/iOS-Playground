//
//  LoadTestsTableViewController.m
//  SRL.Objective-C
//
//  Created by Eyal Fingold on 1/25/15.
//  Copyright (c) 2015 Eyal Fingold. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LoadTestsTableViewController.h"
#import "DetailLoadTestViewController.h"
#import "LoadTestsModel.h"
#import "DetailLoadTestViewController.h"
#import <Foundation/Foundation.h>

#define MAINLABEL_TAG 1
#define SECONDLABEL_TAG 2
#define PHOTO_TAG 3


@interface LoadTestsTableViewController ()
//theDataModel

@end

@implementation LoadTestsTableViewController


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Registering notification message RefreshLoadTests and hooking into refreshTableWithNotification, so to be able to get outside notifications for data update.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableWithNotification:) name:@"RefreshLoadTests" object:nil];
    
    self.theDataModel = [[LoadTestsModel alloc] init];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(refreshView:)  forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    [[self theDataModel] updateData];
}

- (void)refreshTableWithNotification:(NSNotification *)notification
{
    
    if([NSThread isMainThread]){
        [self.tableView reloadData];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];

        });    }
}

//updating data from server
- (void)refreshView:(UIRefreshControl *)refresh {

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


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
         NSDictionary *aDict = self.theDataModel.LoadTests[indexPath.row];
        [[segue destinationViewController] setDetailItem:aDict];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.theDataModel.LoadTests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *object = self.theDataModel.LoadTests[indexPath.row];
    cell.textLabel.text = object[@"name"];
    [cell setAccessoryType:(UITableViewCellAccessoryDisclosureIndicator)];
    return cell;
    */
    static NSString *CellIdentifier = @"Cell";
    UILabel *textLabel, *secondLabel;
    UIImageView *photo;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        
        /*DetailLoadTestViewController *nextViewController = [DetailLoadTestViewController alloc];

        UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"showDetail" source:self destination: nextViewController;
        */
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];        

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 270.0, 43.0)];
        textLabel.tag = MAINLABEL_TAG;
        textLabel.font = [UIFont systemFontOfSize:14.0];
        textLabel.textColor = [UIColor blackColor];
        [cell.contentView addSubview:textLabel];
        
        secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 20.0, 220.0, 25.0)];
        secondLabel.tag = SECONDLABEL_TAG;
        secondLabel.font = [UIFont systemFontOfSize:12.0];
        secondLabel.textColor = [UIColor darkGrayColor];
        [cell.contentView addSubview:secondLabel];
        
        photo = [[UIImageView alloc] initWithFrame:CGRectMake(250, 0.0, 45, 45.0)];
        photo.tag = PHOTO_TAG;
        photo.translatesAutoresizingMaskIntoConstraints = NO;
        [cell.contentView addSubview:photo];
        
        
        
    } else {
        textLabel = (UILabel *)[cell.contentView viewWithTag:MAINLABEL_TAG];
        secondLabel = (UILabel *)[cell.contentView viewWithTag:SECONDLABEL_TAG];
        photo = (UIImageView *)[cell.contentView viewWithTag:PHOTO_TAG];
    }
    NSDictionary *aDict = self.theDataModel.LoadTests[indexPath.row];
    textLabel.text = [aDict objectForKey:@"name"];
    
    
    double unixTimeStamp =[[[aDict objectForKey:@"modified_date"] substringToIndex:10] doubleValue];
   
    NSTimeInterval _interval=(NSTimeInterval)unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    formatter.timeStyle = NSDateFormatterMediumStyle;
    NSString *dateString = [formatter stringFromDate:date];
    
    
     secondLabel.text =dateString;
//    cell.textLabel.text = [aDict objectForKey:@"name"];
    //NSString *imagePath = [[NSBundle mainBundle] pathForResource:[aDict objectForKey:@"ui_status"] ofType:@"png"];
    //ֿUIImage *theImage = [UIImage imageWithContentsOfFile:imagePath];
    //SYSTEM_ERROR
    //PASSED - ok
    //NEW - ok
    //FAILED - ok
    //RUNNING (blue new)
    //ABORTED
    //STOPPED - ok
    //INITIALIZING
    NSString* imageName = [aDict objectForKey:@"ui_status"];
    photo.image = [UIImage imageNamed: imageName];
;
    
    return cell;

    
    
}


@end
