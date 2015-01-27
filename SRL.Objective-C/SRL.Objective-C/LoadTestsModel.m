//
//  LoadTest.m
//  SRL.Objective-C
//
//  Created by Eyal Fingold on 1/26/15.
//  Copyright (c) 2015 Eyal Fingold. All rights reserved.
//

#import "LoadTestsModel.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LoadTestsModel ()

@property Boolean isUpdatingData;

@end

@implementation LoadTestsModel

-(id)init {
    if ( self = [super init] ) {
        self.LoadTests = [[NSMutableArray alloc] init];
        self.isUpdatingData = false;
    }
    return self;
}


-(void) updateData {

    if (self.isUpdatingData==false)
    {
        self.isUpdatingData = true;
        // checking if we already have items if so this is going to delte items inorder to update again from server
        if (self.LoadTests.count >0)
        {
            
            for (NSUInteger i=0; i<=self.LoadTests.count-1; i++)
            {
                [self.LoadTests removeObjectAtIndex:0];
            }
            NSLog(@"Going to create new object array");
            self.LoadTests = [[NSMutableArray alloc] init];
            NSLog(@"After new object array");
        }
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://localhost:3030/api/load-tests?TENANTID=eyalf2"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", json);
            
            for (NSDictionary *ltest in json)
            {
                [self insertNewLoadTest:ltest];
                NSLog(@"%@", ltest[@"create_by"]);
                NSLog(@"%@", ltest[@"name"]);
                NSLog(@"%@", ltest[@"id"]);
                NSLog(@"%@", ltest[@"ui_status"]);
            }
            
            // turning off network activity indicator
            [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
            // sending notification for registered controllers
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshLoadTests" object:nil userInfo:nil];
            
            self.isUpdatingData = false;
        }];
        
        [dataTask resume];
        
    }

}

- (void)insertNewLoadTest:(id)NewLoadTest {
    
    if (!self.LoadTests) {
        self.LoadTests = [[NSMutableArray alloc] init];
    }
    [self.LoadTests insertObject:NewLoadTest atIndex:0];
}


@end
