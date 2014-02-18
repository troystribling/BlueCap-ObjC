//
//  GnosusProfiles.h
//  BlueCap
//
//  Created by Troy Stribling on 1/11/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Hello World

#define GNOSUS_HELLO_WORLD_GREETING         @"Greeting"
#define GNOSUS_HELLO_WORLD_UPDATE_PERIOD    @"Update Period"

#define GNOSUS_DEVICE_TEMPERATURE           @"Temperature"

@interface GnosusProfiles : NSObject

+ (void)create;

@end
