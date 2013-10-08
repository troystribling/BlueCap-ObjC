//
//  TISensorTagServiceProfile.h
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TISENSOR_TAG_ACCELEROMETER_PERIOD       @"TISensorTagAccelerometerPeriod"
#define TISENSOR_TAG_ACCELEROMETER_VALUES       @"TISensorTagAccelerometerValues"
#define TISENSOR_TAG_ACCELEROMTER_ENABLED       @"Enabled"
#define TISENSOR_TAG_ACCELEROMETER_ON           @"TISensorTagAccelerometerOn"
#define TISENSOR_TAG_ACCELEROMETER_ON_VALUE     0x01
#define TISENSOR_TAG_ACCELEROMETER_OFF           @"TISensorTagAccelerometerOff"
#define TISENSOR_TAG_ACCELEROMETER_OFF_VALUE     0x00

@interface TISensorTagServiceProfile : NSObject

+ (void)create;

@end
