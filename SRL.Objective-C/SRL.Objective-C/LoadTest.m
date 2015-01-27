//
//  LoadTest.m
//  SRL.Objective-C
//
//  Created by Eyal Fingold on 1/26/15.
//  Copyright (c) 2015 Eyal Fingold. All rights reserved.
//

#import "LoadTest.h"
#import <Foundation/Foundation.h>

@interface LoadTestModel ()

@end

@implementation LoadTestModel

-(id)initWithDict:(NSNumber *)loadTestID WithName:(NSString *)name WithDescription:(NSString *)description {

        self = [super init];
        if(self)
        {
            self.LoadTestID = loadTestID;
            self.Name =  name;
            self.Description =  description;
        }
        return self;
    }

-(id)initWithDict:(NSNumber *)loadTestID WithName:(NSString *)name {

    self = [super init];
    if(self)
    {
        self.LoadTestID = loadTestID;
        self.Name =  name;
    }
    return self;

}

@end
