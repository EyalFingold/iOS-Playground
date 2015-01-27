//
//  LoadTestsModel.h
//  SRL.Objective-C
//
//  Created by Eyal Fingold on 1/27/15.
//  Copyright (c) 2015 Eyal Fingold. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface LoadTestsModel : NSObject

@property(nonatomic, retain)  NSMutableArray *LoadTests;

-(void) updateData;

-(void)insertNewLoadTest:(id)NewLoadTest;


@end