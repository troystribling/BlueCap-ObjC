//
//  GnosusProfiles.h
//  BlueCap
//
//  Created by Troy Stribling on 1/11/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma - mark Service UUIDs -

#define GNOSUS_HELLO_WORLD_SERVICE_UUID     @"2f0a0000-69aa-f316-3e78-4194989a6c1a"
#define GNOSUS_LOCATION_SERVICE_UUID        @"2f0a0016-69aa-f316-3e78-4194989a6c1a"
#define GNOSUS_EPOC_TIME_UUID               @"2f0a0023-69aa-f316-3e78-4194989a6c1a"

#pragma mark - Hello World -

#define GNOSUS_HELLO_WORLD_GREETING         @"Greeting"
#define GNOSUS_HELLO_WORLD_UPDATE_PERIOD    @"Update Period"

#pragma mark - Location -

#define GNOSUS_LOCATION_LATITUDE            @"Latitude"
#define GNOSUS_LOCATION_LONGITUDE           @"Longitude"

#pragma mark - Epoc Time - 

#define GNOSUS_EPOC_TIME_TIME               @"Time"

#pragma mark -

@interface GnosusProfiles : NSObject

+ (void)create;

@end
