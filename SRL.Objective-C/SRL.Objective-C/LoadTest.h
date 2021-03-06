//
//  LoadTests.h
//  SRL.Objective-C
//
//  Created by Eyal Fingold on 1/25/15.
//  Copyright (c) 2015 Eyal Fingold. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface LoadTestModel:NSObject

-(id)initWithDict:(NSNumber *)loadTestID WithName:(NSString *)name WithDescription:(NSString *)description ;
-(id)initWithDict:(NSNumber *)loadTestID WithName:(NSString *)name;


@property ( nonatomic) NSNumber *LoadTestID;
@property ( nonatomic) NSString *Name;
@property ( nonatomic) NSString *Description;
@property ( nonatomic) NSDate *last_run_date;
@property ( nonatomic) NSDate *modified_date;
@property ( nonatomic) NSDate *create_date;
@property ( nonatomic) NSString *create_by;
@property ( nonatomic) NSString *modified_by;

@end

/*

 "create_by": "Guest",
 "create_date": "1421071296727",
 "description": null,
 "id": 5,
 "last_run_date": null,
 "modified_by": "Guest",
 "modified_date": "1421071296727",
 "name": "New Test4",
 "running_job_id": null,
 "type": 0,
 "baseline_run": null,
 "last_run": null,
 "ui_status": "NEW"
 },

 
 
 NSString *epochTime = @"1352716800";
 
 // (Step 1) Convert epoch time to SECONDS since 1970
 NSTimeInterval seconds = [epochTime doubleValue];
 NSLog (@"Epoch time %@ equates to %qi seconds since 1970", epochTime, (long long) seconds);
 
 // (Step 2) Create NSDate object
 NSDate *epochNSDate = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
 NSLog (@"Epoch time %@ equates to UTC %@", epochTime, epochNSDate);
 

*/