//
//  LoadTestsTableViewController.h
//  SRL.Objective-C
//
//  Created by Eyal Fingold on 1/25/15.
//  Copyright (c) 2015 Eyal Fingold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadTestsModel.h"

@interface LoadTestsTableViewController : UITableViewController

@property (nonatomic, retain) LoadTestsModel *theDataModel;
@property Boolean isUpdatingData;

@end

