//
//  DetailLoadTestViewController.m
//  SRL.Objective-C
//
//  Created by Eyal Fingold on 1/25/15.
//  Copyright (c) 2015 Eyal Fingold. All rights reserved.
//

#import "DetailLoadTestViewController.h"
#import <Foundation/NSObject.h>

@interface DetailLoadTestViewController ()

@end

@implementation DetailLoadTestViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        NSDictionary *aDict = self.detailItem;
//        if (([aDict objectForKey:@"description"]!=nil)&&(![[aDict objectForKey:@"description"] isEmpty])&&(![[aDict objectForKey:@"description"] isEqual:@"null"]))
//        {
        if(![[aDict objectForKey:@"description"] isEqual:[NSNull null]])
        {
            self.detailDescriptionLabel.text = [aDict objectForKey:@"description"];
        }
        //self.detailDescriptionLabel.text = [aDict objectForKey:@"name"];
        //self.navigationItem.title = [aDict objectForKey:@"name"];
//        }
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, CGRectGetWidth(self.navigationController.navigationBar.frame), 14)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = [aDict objectForKey:@"name"];
        
        
        double unixTimeStamp =[[[aDict objectForKey:@"modified_date"] substringToIndex:10] doubleValue];
        NSTimeInterval _interval=(NSTimeInterval)unixTimeStamp;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
        [formatter setLocale:[NSLocale currentLocale]];
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterShortStyle;
        NSString *dateString = [formatter stringFromDate:date];
        
        UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 23, CGRectGetWidth(self.navigationController.navigationBar.frame), 14)];
        subTitleLabel.backgroundColor = [UIColor clearColor];
        subTitleLabel.textColor = [UIColor blackColor];
        subTitleLabel.font = [UIFont systemFontOfSize:12];        subTitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        subTitleLabel.textAlignment = NSTextAlignmentCenter;
        subTitleLabel.text = dateString;
        
        UIView *twoLineTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAX(subTitleLabel.frame.size.width, titleLabel.frame.size.width), 30)];
        [twoLineTitleView addSubview:titleLabel];
        [twoLineTitleView addSubview:subTitleLabel];
        
        float widthDiff = subTitleLabel.frame.size.width - titleLabel.frame.size.width;
        
        if (widthDiff > 0) {
            CGRect frame = titleLabel.frame;
            frame.origin.x = widthDiff / 2;
            titleLabel.frame = CGRectIntegral(frame);
        }else{
            CGRect frame = subTitleLabel.frame;
            frame.origin.x = abs(widthDiff) / 2;
            subTitleLabel.frame = CGRectIntegral(frame);
        }
        
        self.navigationItem.titleView = twoLineTitleView;
        
        // Setting Action (Run Test, Stop Test)
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Run Test" style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(doSomething:)];
        
        self.navigationItem.rightBarButtonItem = anotherButton;
        
    }
}

- (IBAction)doSomething:(id)sender {
    NSLog(@"Running a Test");
    NSDictionary *aDict = self.detailItem;
    NSString *testName = [aDict objectForKey:@"name"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
  
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
