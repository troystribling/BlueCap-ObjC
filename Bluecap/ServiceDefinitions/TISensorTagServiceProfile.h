//
//  TISensorTagServiceProfile.h
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Accelerometer

#define TISENSOR_TAG_ACCELEROMTER_ENABLED           @"Enabled"
#define TISENSOR_TAG_ACCELEROMETER_ON               @"TISensorTagAccelerometerOn"
#define TISENSOR_TAG_ACCELEROMETER_ON_VALUE         0x01
#define TISENSOR_TAG_ACCELEROMETER_OFF              @"TISensorTagAccelerometerOff"
#define TISENSOR_TAG_ACCELEROMETER_OFF_VALUE        0x00

#define TISENSOR_TAG_ACCELEROMTER_VALUE_X_COMPONENT @"X Acceleration"
#define TISENSOR_TAG_ACCELEROMTER_VALUE_Y_COMPONENT @"Y Acceleration"
#define TISENSOR_TAG_ACCELEROMTER_VALUE_Z_COMPONENT @"Z Acceleration"

#define TISENSOR_TAG_ACCELEROMETER_UPDATE_PERIOD    @"Update Period"

@interface TISensorTagServiceProfile : NSObject

+ (void)create;

@end
