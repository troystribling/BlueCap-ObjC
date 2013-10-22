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

#define TISENSOR_TAG_ACCELEROMETER_ON               @"Yes"
#define TISENSOR_TAG_ACCELEROMETER_ON_VALUE         0x01
#define TISENSOR_TAG_ACCELEROMETER_OFF              @"No"
#define TISENSOR_TAG_ACCELEROMETER_OFF_VALUE        0x00

#define TISENSOR_TAG_ACCELEROMTER_VALUE_X_COMPONENT @"X Acceleration"
#define TISENSOR_TAG_ACCELEROMTER_VALUE_Y_COMPONENT @"Y Acceleration"
#define TISENSOR_TAG_ACCELEROMTER_VALUE_Z_COMPONENT @"Z Acceleration"

#define TISENSOR_TAG_ACCELEROMETER_UPDATE_PERIOD    @"Update Period"

#pragma mark -
#pragma mark Barometer

#define TISENSOR_TAG_BAROMETER_ON                       @"Yes"
#define TISENSOR_TAG_BAROMETER_ON_VALUE                 0x01
#define TISENSOR_TAG_BAROMETER_OFF                      @"No"
#define TISENSOR_TAG_BAROMETER_OFF_VALUE                0x00
#define TISENSOR_TAG_BAROMETER_READ_CALIBRATION         @"Read Calibration Data"
#define TISENSOR_TAG_BAROMETER_READ_CALIBRATION_VALUE   0x02

#pragma mark - 
#pragma mark Temperature

#define TISENSOR_TAG_TEMPERATURE_ENABLED            @"Enabled"
#define TISENSOR_TAG_TEMPERATURE_ON                 @"Yes"
#define TISENSOR_TAG_TEMPERATURE_ON_VALUE           0x01
#define TISENSOR_TAG_TEMPERATURE_OFF                @"No"
#define TISENSOR_TAG_TEMPERATURE_OFF_VALUE          0x00

#pragma mark -
#pragma mark Gyrosope

#define TISENSOR_TAG_GYROSCOPE_X_AXIS_ON            @"X-Axis Enables"
#define TISENSOR_TAG_GYROSCOPE_X_AXIS_ON_VALUE      0x01
#define TISENSOR_TAG_GYROSCOPE_Y_AXIS_ON            @"Y-Axis Enabled"
#define TISENSOR_TAG_GYROSCOPE_Y_AXIS_ON_VALUE      0x02
#define TISENSOR_TAG_GYROSCOPE_XY_AXIS_ON           @"XY-Axis Enabled"
#define TISENSOR_TAG_GYROSCOPE_XY_AXIS_ON_VALUE     0x03
#define TISENSOR_TAG_GYROSCOPE_Z_AXIS_ON            @"Z-Axis Enabled"
#define TISENSOR_TAG_GYROSCOPE_Z_AXIS_ON_VALUE      0x04
#define TISENSOR_TAG_GYROSCOPE_XZ_AXIS_ON           @"XZ-Axis Enabled"
#define TISENSOR_TAG_GYROSCOPE_XZ_AXIS_ON_VALUE     0x05
#define TISENSOR_TAG_GYROSCOPE_YZ_AXIS_ON           @"YZ-Axis Enabled"
#define TISENSOR_TAG_GYROSCOPE_YZ_AXIS_ON_VALUE     0x06
#define TISENSOR_TAG_GYROSCOPE_XYZ_AXIS_ON          @"XYZ-Axis Enabled"
#define TISENSOR_TAG_GYROSCOPE_XYZ_AXIS_ON_VALUE    0x07
#define TISENSOR_TAG_GYROSCOPE_OFF                  @"No"
#define TISENSOR_TAG_GYROSCOPE_OFF_VALUE            0x00

#pragma mark -
#pragma mark Magnetometer

#define TISENSOR_TAG_MAGNETOMETER_ON                @"Yes"
#define TISENSOR_TAG_MAGNETOMETER_ON_VALUE          0x01
#define TISENSOR_TAG_MAGNETOMETER_OFF               @"No"
#define TISENSOR_TAG_MAGNETOMETER_OFF_VALUE         0x00

#pragma mark -
#pragma mark Hygrometer

#define TISENSOR_TAG_HYGROMETER_ON                @"Yes"
#define TISENSOR_TAG_HYGROMETER_ON_VALUE          0x01
#define TISENSOR_TAG_HYGROMETER_OFF               @"No"
#define TISENSOR_TAG_HYGROMETER_OFF_VALUE         0x00

#pragma mark -
#pragma mark Device Test


@interface TISensorTagServiceProfile : NSObject

+ (void)create;

@end
