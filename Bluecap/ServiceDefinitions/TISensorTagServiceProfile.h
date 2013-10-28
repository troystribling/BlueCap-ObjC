//
//  TISensorTagServiceProfile.h
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Accelerometer

#define TISENSOR_TAG_ACCELEROMETER_ON               @"Yes"
#define TISENSOR_TAG_ACCELEROMETER_ON_VALUE         0x01
#define TISENSOR_TAG_ACCELEROMETER_OFF              @"No"
#define TISENSOR_TAG_ACCELEROMETER_OFF_VALUE        0x00

#define TISENSOR_TAG_ACCELEROMTER_X_COMPONENT       @"X Acceleration"
#define TISENSOR_TAG_ACCELEROMTER_Y_COMPONENT       @"Y Acceleration"
#define TISENSOR_TAG_ACCELEROMTER_Z_COMPONENT       @"Z Acceleration"
#define TISENSOR_TAG_ACCELEROMTER_RAW_X_COMPONENT   @"Raw X Acceleration"
#define TISENSOR_TAG_ACCELEROMTER_RAW_Y_COMPONENT   @"Raw Y Acceleration"
#define TISENSOR_TAG_ACCELEROMTER_RAW_Z_COMPONENT   @"Raw Z Acceleration"

#define TISENSOR_TAG_ACCELEROMETER_UPDATE_PERIOD    @"Update Period"

#pragma mark - Barometer

#define TISENSOR_TAG_BAROMETER_ON                       @"Yes"
#define TISENSOR_TAG_BAROMETER_ON_VALUE                 0x01
#define TISENSOR_TAG_BAROMETER_OFF                      @"No"
#define TISENSOR_TAG_BAROMETER_OFF_VALUE                0x00
#define TISENSOR_TAG_BAROMETER_READ_CALIBRATION         @"Read Calibration Data"
#define TISENSOR_TAG_BAROMETER_READ_CALIBRATION_VALUE   0x02

#define TISENSOR_TAG_BAROMETER_CALIBRATION_C1               @"C1"
#define TISENSOR_TAG_BAROMETER_CALIBRATION_C2               @"C2"
#define TISENSOR_TAG_BAROMETER_CALIBRATION_C3               @"C3"
#define TISENSOR_TAG_BAROMETER_CALIBRATION_C4               @"C4"
#define TISENSOR_TAG_BAROMETER_CALIBRATION_C5               @"C5"
#define TISENSOR_TAG_BAROMETER_CALIBRATION_C6               @"C6"
#define TISENSOR_TAG_BAROMETER_CALIBRATION_C7               @"C7"
#define TISENSOR_TAG_BAROMETER_CALIBRATION_C8               @"C8"
#define TISENSOR_TAG_BAROMETER_RAW_TEMPERATURE              @"Raw Temperature"
#define TISENSOR_TAG_BAROMETER_RAW_PRESSURE                 @"Raw Pressure"

#define TISENSOR_TAG_BAROMETER_TEMPERATURE              @"Temperature"
#define TISENSOR_TAG_BAROMETER_PRESSURE                 @"Pressure"

#pragma mark - Temperature

#define TISENSOR_TAG_TEMPERATURE_ON                     @"Yes"
#define TISENSOR_TAG_TEMPERATURE_ON_VALUE               0x01
#define TISENSOR_TAG_TEMPERATURE_OFF                    @"No"
#define TISENSOR_TAG_TEMPERATURE_OFF_VALUE              0x00

#define TISENSOR_TAG_TEMPERATURE_OBJECT                 @"Object Temperature"
#define TISENSOR_TAG_TEMPERATURE_AMBIENT                @"Ambient Temperature"
#define TISENSOR_TAG_RAW_TEMPERATURE_OBJECT             @"Raw Object Temperature"
#define TISENSOR_TAG_RAW_TEMPERATURE_AMBIENT            @"Raw Ambient Temperature"

#pragma mark - Gyrosope

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

#define TISENSOR_TAG_GYROSCOPE_X_COMPONENT          @"X Component"
#define TISENSOR_TAG_GYROSCOPE_Y_COMPONENT          @"Y Component"
#define TISENSOR_TAG_GYROSCOPE_Z_COMPONENT          @"Z Component"
#define TISENSOR_TAG_GYROSCOPE_RAW_X_COMPONENT      @"Raw X Component"
#define TISENSOR_TAG_GYROSCOPE_RAW_Y_COMPONENT      @"Raw Y Component"
#define TISENSOR_TAG_GYROSCOPE_RAW_Z_COMPONENT      @"Raw Z Component"

#pragma mark - Magnetometer

#define TISENSOR_TAG_MAGNETOMETER_ON                @"Yes"
#define TISENSOR_TAG_MAGNETOMETER_ON_VALUE          0x01
#define TISENSOR_TAG_MAGNETOMETER_OFF               @"No"
#define TISENSOR_TAG_MAGNETOMETER_OFF_VALUE         0x00

#define TISENSOR_TAG_MAGNETOMETER_X_COMPONENT           @"X Component"
#define TISENSOR_TAG_MAGNETOMETER_Y_COMPONENT           @"Y Component"
#define TISENSOR_TAG_MAGNETOMETER_Z_COMPONENT           @"Z Component"
#define TISENSOR_TAG_MAGNETOMETER_RAW_X_COMPONENT       @"Raw X Component"
#define TISENSOR_TAG_MAGNETOMETER_RAW_Y_COMPONENT       @"Raw Y Component"
#define TISENSOR_TAG_MAGNETOMETER_RAW_Z_COMPONENT       @"Raw Z Component"

#define TISENSOR_TAG_MAGNETOMETER_UPDATE_PERIOD         @"Update Period"

#pragma mark - Hygrometer

#define TISENSOR_TAG_HYGROMETER_ON                @"Yes"
#define TISENSOR_TAG_HYGROMETER_ON_VALUE          0x01
#define TISENSOR_TAG_HYGROMETER_OFF               @"No"
#define TISENSOR_TAG_HYGROMETER_OFF_VALUE         0x00

#define TISENSOR_TAG_HYGROMETER_TEMPERATURE         @"Temperature"
#define TISENSOR_TAG_HYGROMETER_HUMIDITY            @"Humidity"
#define TISENSOR_TAG_HYGROMETER_RAW_TEMPERATURE     @"Raw Temperature"
#define TISENSOR_TAG_HYGROMETER_RAW_HUMIDITY        @"Raw Humidity"

#pragma mark - Device Test

#define TISENSOR_TAG_TEST_ON                @"YES"
#define TISENSOR_TAG_TEST_ON_VALUE          0x83
#define TISENSOR_TAG_TEST_OFF               @"NO"
#define TISENSOR_TAG_TEST_OFF_VALUE         0x00

#define TISENSOR_TAG_TEST_1_RESULT          @"Test 1"
#define TISENSOR_TAG_TEST_2_RESULT          @"Test 2"
#define TISENSOR_TAG_TEST_3_RESULT          @"Test 3"
#define TISENSOR_TAG_TEST_4_RESULT          @"Test 4"
#define TISENSOR_TAG_TEST_5_RESULT          @"Test 5"
#define TISENSOR_TAG_TEST_6_RESULT          @"Test 6"
#define TISENSOR_TAG_TEST_7_RESULT          @"Test 7"
#define TISENSOR_TAG_TEST_8_RESULT          @"Test 8"

#define TISENSOR_TAG_KEY_PRESSED            @"Key"

@interface TISensorTagServiceProfile : NSObject

+ (void)create;

@end
