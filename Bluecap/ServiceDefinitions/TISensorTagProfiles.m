//
//  TISensorTagProfiles.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCap.h"
#import "TISensorTagProfiles.h"

@implementation TISensorTagProfiles

+ (void)create {
    
    BlueCapProfileManager* profileManager = [BlueCapProfileManager sharedInstance];
    
#pragma mark - Accelerometer

    [profileManager createServiceWithUUID:TISENSOR_TAG_ACCELEROMETER_SERVICE_UUID
                                     name:@"TI Accelerometer"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                   
        // units are in g
        [serviceProfile createCharacteristicWithUUID:@"f000aa11-0451-4000-b000-000000000000"
                                                name:@"Accelerometer Data"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  NSNumber* xCompNumber = blueCapCharFromData(data, NSMakeRange(0,1));
                                                  NSNumber* yCompNumber = blueCapCharFromData(data, NSMakeRange(1,1));
                                                  NSNumber* zCompNumber = blueCapCharFromData(data, NSMakeRange(2,1));
                                                  float xComp = -[xCompNumber floatValue]/64.0f;
                                                  float yComp = -[yCompNumber floatValue]/64.0f;
                                                  float zComp = [zCompNumber floatValue]/64.0f;
                                                  return @{TISENSOR_TAG_ACCELEROMTER_X_COMPONENT:[NSNumber numberWithFloat:xComp],
                                                           TISENSOR_TAG_ACCELEROMTER_Y_COMPONENT:[NSNumber numberWithFloat:yComp],
                                                           TISENSOR_TAG_ACCELEROMTER_Z_COMPONENT:[NSNumber numberWithFloat:zComp],
                                                           TISENSOR_TAG_ACCELEROMTER_RAW_X_COMPONENT:xCompNumber,
                                                           TISENSOR_TAG_ACCELEROMTER_RAW_Y_COMPONENT:yCompNumber,
                                                           TISENSOR_TAG_ACCELEROMTER_RAW_Z_COMPONENT:zCompNumber};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return @{TISENSOR_TAG_ACCELEROMTER_X_COMPONENT:
                                                               [NSString stringWithFormat:@"%.02f", [[data objectForKey:TISENSOR_TAG_ACCELEROMTER_X_COMPONENT] floatValue]],
                                                           TISENSOR_TAG_ACCELEROMTER_Y_COMPONENT:
                                                               [NSString stringWithFormat:@"%.02f", [[data objectForKey:TISENSOR_TAG_ACCELEROMTER_Y_COMPONENT] floatValue]],
                                                           TISENSOR_TAG_ACCELEROMTER_Z_COMPONENT:
                                                               [NSString stringWithFormat:@"%.02f", [[data objectForKey:TISENSOR_TAG_ACCELEROMTER_Z_COMPONENT] floatValue]],
                                                           TISENSOR_TAG_ACCELEROMTER_RAW_X_COMPONENT:
                                                               [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_ACCELEROMTER_RAW_X_COMPONENT] intValue]],
                                                           TISENSOR_TAG_ACCELEROMTER_RAW_Y_COMPONENT:
                                                               [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_ACCELEROMTER_RAW_Y_COMPONENT] intValue]],
                                                           TISENSOR_TAG_ACCELEROMTER_RAW_Z_COMPONENT:
                                                               [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_ACCELEROMTER_RAW_Z_COMPONENT] intValue]]};
                                              }];
                                              [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                  int8_t intVals[3];
                                                  intVals[0] = [[data objectForKey:TISENSOR_TAG_ACCELEROMTER_RAW_X_COMPONENT] intValue];
                                                  intVals[1] = [[data objectForKey:TISENSOR_TAG_ACCELEROMTER_RAW_Y_COMPONENT] intValue];
                                                  intVals[2] = [[data objectForKey:TISENSOR_TAG_ACCELEROMTER_RAW_Z_COMPONENT] intValue];
                                                  return blueCapCharArrayToData(intVals, 3);
                                              }];
                                              characteristicProfile.initialValue =
                                                  [characteristicProfile valueFromString:@{TISENSOR_TAG_ACCELEROMTER_RAW_X_COMPONENT:[NSString stringWithFormat:@"%d", -2],
                                                                                           TISENSOR_TAG_ACCELEROMTER_RAW_Y_COMPONENT:[NSString stringWithFormat:@"%d", 6],
                                                                                           TISENSOR_TAG_ACCELEROMTER_RAW_Z_COMPONENT:[NSString stringWithFormat:@"%d", 69]}];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"f000aa12-0451-4000-b000-000000000000"
                                                name:@"Accelerometer Enabled"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_ACCELEROMETER_ON_VALUE)
                                                                        named:TISENSOR_TAG_ACCELEROMETER_ON];
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_ACCELEROMETER_OFF_VALUE)
                                                                        named:TISENSOR_TAG_ACCELEROMETER_OFF];
                                              [characteristicProfile afterDiscovered:^(BlueCapCharacteristic* characteristic) {
                                                  [characteristic writeValueObject:TISENSOR_TAG_ACCELEROMETER_ON afterWriteCall:nil];
                                              }];
                                              characteristicProfile.initialValue = [characteristicProfile valueFromNamedObject:TISENSOR_TAG_ACCELEROMETER_OFF];
                                          }];
            
        // units are ms
        [serviceProfile createCharacteristicWithUUID:@"f000aa13-0451-4000-b000-000000000000"
                                                name:@"Accelerometer Update Period"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile serializeObject:^NSData*(id data) {
                                                  uint8_t intVal = [data intValue]/10;
                                                  if (intVal < 0x0a) {
                                                      intVal = 0x0a;
                                                  }
                                                  return blueCapUnsignedCharToData(intVal);
                                              }];
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  int unscaledValue = 10*[blueCapUnsignedCharFromData(data, NSMakeRange(0, 1)) intValue];
                                                  return @{TISENSOR_TAG_ACCELEROMETER_UPDATE_PERIOD:[NSNumber numberWithInt:unscaledValue]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return @{TISENSOR_TAG_ACCELEROMETER_UPDATE_PERIOD:[[data objectForKey:TISENSOR_TAG_ACCELEROMETER_UPDATE_PERIOD] stringValue]};
                                              }];
                                              [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                  uint8_t intVal = [[data objectForKey:TISENSOR_TAG_ACCELEROMETER_UPDATE_PERIOD] intValue]/10;
                                                  if (intVal < 0x0a) {
                                                      intVal = 0x0a;
                                                  }
                                                  return blueCapUnsignedCharToData(intVal);
                                              }];
                                              characteristicProfile.initialValue = blueCapUnsignedCharToData(0x64);
                                          }];
                                   
    }];

#pragma mark - Magnetometer

    [profileManager createServiceWithUUID:TISENSOR_TAG_MAGNETOMETER_SERVICE_UUID
                                     name:@"TI Magnetometer"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
        // units are uT
        [serviceProfile createCharacteristicWithUUID:@"f000aa31-0451-4000-b000-000000000000"
                                                name:@"Magnetometer Data"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  NSNumber* xCompNumber = blueCapInt16LittleFromData(data, NSMakeRange(0, 2));
                                                  NSNumber* yCompNumber = blueCapInt16LittleFromData(data, NSMakeRange(2, 2));
                                                  NSNumber* zCompNumber = blueCapInt16LittleFromData(data, NSMakeRange(4, 2));
                                                  double xComp = -[xCompNumber doubleValue]*2000.0/65536.0;
                                                  double yComp = -[yCompNumber doubleValue]*2000.0/65536.0;
                                                  double zComp = [zCompNumber doubleValue]*2000.0/65536.0;
                                                  return @{TISENSOR_TAG_MAGNETOMETER_X_COMPONENT:[NSNumber numberWithDouble:xComp],
                                                           TISENSOR_TAG_MAGNETOMETER_Y_COMPONENT:[NSNumber numberWithDouble:yComp],
                                                           TISENSOR_TAG_MAGNETOMETER_Z_COMPONENT:[NSNumber numberWithDouble:zComp],
                                                           TISENSOR_TAG_MAGNETOMETER_RAW_X_COMPONENT: xCompNumber,
                                                           TISENSOR_TAG_MAGNETOMETER_RAW_Y_COMPONENT: yCompNumber,
                                                           TISENSOR_TAG_MAGNETOMETER_RAW_Z_COMPONENT: zCompNumber};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return @{TISENSOR_TAG_MAGNETOMETER_X_COMPONENT:
                                                               [NSString stringWithFormat:@"%.01f", [[data objectForKey:TISENSOR_TAG_MAGNETOMETER_X_COMPONENT] floatValue]],
                                                           TISENSOR_TAG_MAGNETOMETER_Y_COMPONENT:
                                                               [NSString stringWithFormat:@"%.01f", [[data objectForKey:TISENSOR_TAG_MAGNETOMETER_Y_COMPONENT] floatValue]],
                                                           TISENSOR_TAG_MAGNETOMETER_Z_COMPONENT:
                                                               [NSString stringWithFormat:@"%.01f", [[data objectForKey:TISENSOR_TAG_MAGNETOMETER_Z_COMPONENT] floatValue]],
                                                           TISENSOR_TAG_MAGNETOMETER_RAW_X_COMPONENT:
                                                               [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_MAGNETOMETER_RAW_X_COMPONENT] intValue]],
                                                           TISENSOR_TAG_MAGNETOMETER_RAW_Y_COMPONENT:
                                                               [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_MAGNETOMETER_RAW_Y_COMPONENT] intValue]],
                                                           TISENSOR_TAG_MAGNETOMETER_RAW_Z_COMPONENT:
                                                               [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_MAGNETOMETER_RAW_Z_COMPONENT] intValue]]};
                                              }];
                                              [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                  int16_t intVals[3];
                                                  intVals[0] = [[data objectForKey:TISENSOR_TAG_MAGNETOMETER_RAW_X_COMPONENT] intValue];
                                                  intVals[1] = [[data objectForKey:TISENSOR_TAG_MAGNETOMETER_RAW_Y_COMPONENT] intValue];
                                                  intVals[2] = [[data objectForKey:TISENSOR_TAG_MAGNETOMETER_RAW_Z_COMPONENT] intValue];
                                                  return blueCapLittleFromInt16Array(intVals, 3);
                                              }];
                                              characteristicProfile.initialValue =
                                                  [characteristicProfile valueFromString:@{TISENSOR_TAG_MAGNETOMETER_RAW_X_COMPONENT:[NSString stringWithFormat:@"%d", -2183],
                                                                                           TISENSOR_TAG_MAGNETOMETER_RAW_Y_COMPONENT:[NSString stringWithFormat:@"%d", 1916],
                                                                                           TISENSOR_TAG_MAGNETOMETER_RAW_Z_COMPONENT:[NSString stringWithFormat:@"%d", 1255]}];
                                          }];
      
        [serviceProfile createCharacteristicWithUUID:@"f000aa32-0451-4000-b000-000000000000"
                                                name:@"Magnetometer Enabled"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_MAGNETOMETER_ON_VALUE) named:TISENSOR_TAG_MAGNETOMETER_ON];
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_MAGNETOMETER_OFF_VALUE) named:TISENSOR_TAG_MAGNETOMETER_OFF];
                                              [characteristicProfile afterDiscovered:^(BlueCapCharacteristic* characteristic) {
                                                  [characteristic writeValueObject:TISENSOR_TAG_MAGNETOMETER_ON afterWriteCall:nil];
                                              }];
                                              characteristicProfile.initialValue = [characteristicProfile valueFromNamedObject:TISENSOR_TAG_MAGNETOMETER_OFF];
                                          }];

        // units are ms
        [serviceProfile createCharacteristicWithUUID:@"f000aa33-0451-4000-b000-000000000000"
                                              name:@"Magnetometer Update Period"
                                        andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                            [characteristicProfile serializeObject:^NSData*(id data) {
                                                int intValue = [data intValue]/10;
                                                uint8_t value = (uint8_t)(intValue);
                                                if (value < 0x0a) {
                                                    value = 0x0a;
                                                }
                                                return [NSData dataWithBytes:&value length:1];
                                            }];
                                            [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                int unscaledValue = 10*[blueCapUnsignedCharFromData(data, NSMakeRange(0, 1)) intValue];
                                                return @{TISENSOR_TAG_MAGNETOMETER_UPDATE_PERIOD:[NSNumber numberWithInt:unscaledValue]};
                                            }];
                                            [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                return @{TISENSOR_TAG_MAGNETOMETER_UPDATE_PERIOD:[[data objectForKey:TISENSOR_TAG_MAGNETOMETER_UPDATE_PERIOD] stringValue]};
                                            }];
                                            [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                uint8_t intVal = [[data objectForKey:TISENSOR_TAG_MAGNETOMETER_UPDATE_PERIOD] intValue]/10;
                                                return blueCapUnsignedCharToData(intVal);
                                            }];
                                            characteristicProfile.initialValue = blueCapUnsignedCharToData(0x64);
                                        }];
                                   
    }];

#pragma mark - Gyroscope

    [profileManager createServiceWithUUID:TISENSOR_TAG_GYROSCOPE_SERVICE_UUID
                                     name:@"TI Gyroscope"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
        // units are degrees
        [serviceProfile createCharacteristicWithUUID:@"f000aa51-0451-4000-b000-000000000000"
                                                name:@"Gyroscope Data"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  NSNumber* xCompNumber = blueCapInt16LittleFromData(data, NSMakeRange(0, 2));
                                                  NSNumber* yCompNumber = blueCapInt16LittleFromData(data, NSMakeRange(2, 2));
                                                  NSNumber* zCompNumber = blueCapInt16LittleFromData(data, NSMakeRange(4, 2));
                                                  double xComp = -[xCompNumber doubleValue]*500.0/65536.0;
                                                  double yComp = -[yCompNumber doubleValue]*500.0/65536.0;
                                                  double zComp = [zCompNumber doubleValue]*500.0/65536.0;
                                                  return @{TISENSOR_TAG_GYROSCOPE_X_COMPONENT:[NSNumber numberWithDouble:xComp],
                                                           TISENSOR_TAG_GYROSCOPE_Y_COMPONENT:[NSNumber numberWithDouble:yComp],
                                                           TISENSOR_TAG_GYROSCOPE_Z_COMPONENT:[NSNumber numberWithDouble:zComp],
                                                           TISENSOR_TAG_GYROSCOPE_RAW_X_COMPONENT: xCompNumber,
                                                           TISENSOR_TAG_GYROSCOPE_RAW_Y_COMPONENT: yCompNumber,
                                                           TISENSOR_TAG_GYROSCOPE_RAW_Z_COMPONENT: zCompNumber};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return @{TISENSOR_TAG_GYROSCOPE_X_COMPONENT:
                                                               [NSString stringWithFormat:@"%.01f", [[data objectForKey:TISENSOR_TAG_GYROSCOPE_X_COMPONENT] floatValue]],
                                                           TISENSOR_TAG_GYROSCOPE_Y_COMPONENT:
                                                               [NSString stringWithFormat:@"%.01f", [[data objectForKey:TISENSOR_TAG_GYROSCOPE_Y_COMPONENT] floatValue]],
                                                           TISENSOR_TAG_GYROSCOPE_Z_COMPONENT:
                                                               [NSString stringWithFormat:@"%.01f", [[data objectForKey:TISENSOR_TAG_GYROSCOPE_Z_COMPONENT] floatValue]],
                                                           TISENSOR_TAG_GYROSCOPE_RAW_X_COMPONENT:
                                                               [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_GYROSCOPE_RAW_X_COMPONENT] intValue]],
                                                           TISENSOR_TAG_GYROSCOPE_RAW_Y_COMPONENT:
                                                               [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_GYROSCOPE_RAW_Y_COMPONENT] intValue]],
                                                           TISENSOR_TAG_GYROSCOPE_RAW_Z_COMPONENT:
                                                               [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_GYROSCOPE_RAW_Z_COMPONENT] intValue]]};
                                              }];
                                              [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                  int16_t intVals[3];
                                                  intVals[0] = [[data objectForKey:TISENSOR_TAG_GYROSCOPE_RAW_X_COMPONENT] intValue];
                                                  intVals[1] = [[data objectForKey:TISENSOR_TAG_GYROSCOPE_RAW_Y_COMPONENT] intValue];
                                                  intVals[2] = [[data objectForKey:TISENSOR_TAG_GYROSCOPE_RAW_Z_COMPONENT] intValue];
                                                  return blueCapLittleFromInt16Array(intVals, 3);
                                              }];
                                              characteristicProfile.initialValue = [characteristicProfile valueFromString:@{TISENSOR_TAG_GYROSCOPE_RAW_X_COMPONENT:[NSString stringWithFormat:@"%d", -247],
                                                                                                                            TISENSOR_TAG_GYROSCOPE_RAW_Y_COMPONENT:[NSString stringWithFormat:@"%d", -219],
                                                                                                                            TISENSOR_TAG_GYROSCOPE_RAW_Z_COMPONENT:[NSString stringWithFormat:@"%d", -23]}];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"f000aa52-0451-4000-b000-000000000000"
                                                name:@"Gyroscope Enabled"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_GYROSCOPE_X_AXIS_ON_VALUE) named:TISENSOR_TAG_GYROSCOPE_X_AXIS_ON];
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_GYROSCOPE_Y_AXIS_ON_VALUE) named:TISENSOR_TAG_GYROSCOPE_Y_AXIS_ON];
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_GYROSCOPE_XY_AXIS_ON_VALUE) named:TISENSOR_TAG_GYROSCOPE_XY_AXIS_ON];
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_GYROSCOPE_Z_AXIS_ON_VALUE) named:TISENSOR_TAG_GYROSCOPE_Z_AXIS_ON];
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_GYROSCOPE_XZ_AXIS_ON_VALUE) named:TISENSOR_TAG_GYROSCOPE_XZ_AXIS_ON];
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_GYROSCOPE_YZ_AXIS_ON_VALUE) named:TISENSOR_TAG_GYROSCOPE_YZ_AXIS_ON];
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_GYROSCOPE_XYZ_AXIS_ON_VALUE) named:TISENSOR_TAG_GYROSCOPE_XYZ_AXIS_ON];
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_GYROSCOPE_OFF_VALUE) named:TISENSOR_TAG_GYROSCOPE_OFF];
                                              [characteristicProfile afterDiscovered:^(BlueCapCharacteristic* characteristic) {
                                                  [characteristic writeValueObject:TISENSOR_TAG_GYROSCOPE_XYZ_AXIS_ON afterWriteCall:nil];
                                              }];
                                              characteristicProfile.initialValue = [characteristicProfile valueFromNamedObject:TISENSOR_TAG_GYROSCOPE_OFF];
                                          }];
                                   
    }];

#pragma mark - Temperature

    [profileManager createServiceWithUUID:TISENSOR_TAG_TEMPERATURE_SERVICE_UUID
                                     name:@"TI IR Temperature Sensor"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
        // units are Celsius
        [serviceProfile createCharacteristicWithUUID:@"f000aa01-0451-4000-b000-000000000000"
                                                name:@"Temperature Data"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  NSNumber* rawObject = blueCapInt16LittleFromData(data, NSMakeRange(0, 2));
                                                  NSNumber* rawAmbient = blueCapInt16LittleFromData(data, NSMakeRange(2, 2));
                                                  double calAmbient = [rawAmbient doubleValue]/128.0;
                                                  double vObj2 = [rawObject doubleValue]*0.00000015625;
                                                  double tDie2 = calAmbient + 273.15;
                                                  double s0 = 6.4*pow(10,-14);
                                                  double a1 = 1.75*pow(10,-3);
                                                  double a2 = -1.678*pow(10,-5);
                                                  double b0 = -2.94*pow(10,-5);
                                                  double b1 = -5.7*pow(10,-7);
                                                  double b2 = 4.63*pow(10,-9);
                                                  double c2 = 13.4f;
                                                  double tRef = 298.15;
                                                  double s = s0*(1+a1*(tDie2 - tRef)+a2*pow((tDie2 - tRef),2));
                                                  double vOs = b0 + b1*(tDie2 - tRef) + b2*pow((tDie2 - tRef),2);
                                                  double fObj = (vObj2 - vOs) + c2*pow((vObj2 - vOs),2);
                                                  double tObj = pow(pow(tDie2,4) + (fObj/s),.25) - 273.15;
                                                  return @{TISENSOR_TAG_TEMPERATURE_AMBIENT:[NSNumber numberWithDouble:calAmbient],
                                                           TISENSOR_TAG_TEMPERATURE_OBJECT:[NSNumber numberWithDouble:tObj],
                                                           TISENSOR_TAG_RAW_TEMPERATURE_AMBIENT:rawAmbient,
                                                           TISENSOR_TAG_RAW_TEMPERATURE_OBJECT:rawObject};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return @{TISENSOR_TAG_TEMPERATURE_AMBIENT:
                                                               [NSString stringWithFormat:@"%.01f", [[data objectForKey:TISENSOR_TAG_TEMPERATURE_AMBIENT] floatValue]],
                                                           TISENSOR_TAG_TEMPERATURE_OBJECT:
                                                               [NSString stringWithFormat:@"%.01f", [[data objectForKey:TISENSOR_TAG_TEMPERATURE_OBJECT] floatValue]],
                                                           TISENSOR_TAG_RAW_TEMPERATURE_AMBIENT:
                                                               [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_RAW_TEMPERATURE_AMBIENT] intValue]],
                                                           TISENSOR_TAG_RAW_TEMPERATURE_OBJECT:
                                                                [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_RAW_TEMPERATURE_OBJECT] intValue]]};
                                              }];
                                              [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                  int16_t intVals[2];
                                                  intVals[0] = [[data objectForKey:TISENSOR_TAG_RAW_TEMPERATURE_OBJECT] intValue];
                                                  intVals[1] = [[data objectForKey:TISENSOR_TAG_RAW_TEMPERATURE_AMBIENT] intValue];
                                                  return blueCapLittleFromInt16Array(intVals, 2);
                                              }];
                                              characteristicProfile.initialValue = [characteristicProfile valueFromString:@{TISENSOR_TAG_RAW_TEMPERATURE_AMBIENT:[NSString stringWithFormat:@"%d", 3100],
                                                                                                                            TISENSOR_TAG_RAW_TEMPERATURE_OBJECT:[NSString stringWithFormat:@"%d", -138]}];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"f000aa02-0451-4000-b000-000000000000"
                                                name:@"Temperature Sensor Enabled"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_TEMPERATURE_ON_VALUE) named:TISENSOR_TAG_TEMPERATURE_ON];
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_TEMPERATURE_OFF_VALUE) named:TISENSOR_TAG_TEMPERATURE_OFF];
                                              [characteristicProfile afterDiscovered:^(BlueCapCharacteristic* characteristic) {
                                                  [characteristic writeValueObject:TISENSOR_TAG_TEMPERATURE_ON afterWriteCall:nil];
                                              }];
                                              characteristicProfile.initialValue = [characteristicProfile valueFromNamedObject:TISENSOR_TAG_TEMPERATURE_OFF];
                                          }];
    }];

#pragma mark - Barometer
/*
    Calibrated Pressure and Temperature are computed as follows
    C1...C8 = Calibration Coefficients, TR = Raw temperature, PR = Raw Pressure, 
    T = Calibrated Temperature in Celcius, P = Calibrated Pressure in Pascals
    
    S = C3 + C4*TR/2^17 + C5*TR^2/2^34
    O = C6*2^14 + C7*TR/8 + C8TR^2/2^19
    P = (S*PR + O)/2^14
    T = C2/2^10 + C1*TR/2^24
*/

    [profileManager createServiceWithUUID:TISENSOR_TAG_BAROMETER_SERVICE_UUID
                                     name:@"TI Barometer"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                
        [serviceProfile createCharacteristicWithUUID:@"f000aa41-0451-4000-b000-000000000000"
                                                name:@"Barometer Data"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{TISENSOR_TAG_BAROMETER_RAW_TEMPERATURE:blueCapInt16LittleFromData(data, NSMakeRange(0, 2)),
                                                           TISENSOR_TAG_BAROMETER_RAW_PRESSURE:blueCapUnsignedInt16LittleFromData(data, NSMakeRange(2, 2))};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return @{TISENSOR_TAG_BAROMETER_RAW_TEMPERATURE:
                                                               [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_BAROMETER_RAW_TEMPERATURE] intValue]],
                                                           TISENSOR_TAG_BAROMETER_RAW_PRESSURE:
                                                               [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_BAROMETER_RAW_PRESSURE] intValue]]};
                                              }];
                                              [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                  int16_t intVals[2];
                                                  intVals[0] = [[data objectForKey: TISENSOR_TAG_BAROMETER_RAW_TEMPERATURE] integerValue];
                                                  intVals[1] = [[data objectForKey:TISENSOR_TAG_BAROMETER_RAW_PRESSURE] integerValue];
                                                  return blueCapLittleFromInt16Array(intVals, 2);
                                              }];
                                              characteristicProfile.initialValue = [characteristicProfile valueFromString:
                                                                                            @{TISENSOR_TAG_BAROMETER_RAW_TEMPERATURE:[NSString stringWithFormat:@"-2343"],
                                                                                              TISENSOR_TAG_BAROMETER_RAW_PRESSURE:[NSString stringWithFormat:@"33995"]}];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"f000aa42-0451-4000-b000-000000000000"
                                                name:@"Barometer Enabled"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_BAROMETER_ON_VALUE) named:TISENSOR_TAG_BAROMETER_ON];
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_BAROMETER_OFF_VALUE) named:TISENSOR_TAG_BAROMETER_OFF];
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_BAROMETER_READ_CALIBRATION_VALUE) named:TISENSOR_TAG_BAROMETER_READ_CALIBRATION];
                                              [characteristicProfile afterDiscovered:^(BlueCapCharacteristic* characteristic) {
                                                  [characteristic writeValueObject:TISENSOR_TAG_BAROMETER_ON afterWriteCall:^(BlueCapCharacteristic* characteristic, NSError* error) {
                                                      [characteristic writeValueObject:TISENSOR_TAG_BAROMETER_READ_CALIBRATION afterWriteCall:nil];
                                                  }];
                                              }];
                                              characteristicProfile.initialValue = [characteristicProfile valueFromNamedObject:TISENSOR_TAG_BAROMETER_OFF];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"f000aa43-0451-4000-b000-000000000000"
                                                name:@"Barometer Calibration Data"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{TISENSOR_TAG_BAROMETER_CALIBRATION_C1:blueCapUnsignedInt16LittleFromData(data, NSMakeRange(0, 2)),
                                                           TISENSOR_TAG_BAROMETER_CALIBRATION_C2:blueCapUnsignedInt16LittleFromData(data, NSMakeRange(2, 2)),
                                                           TISENSOR_TAG_BAROMETER_CALIBRATION_C3:blueCapUnsignedInt16LittleFromData(data, NSMakeRange(4, 2)),
                                                           TISENSOR_TAG_BAROMETER_CALIBRATION_C4:blueCapUnsignedInt16LittleFromData(data, NSMakeRange(6, 2)),
                                                           TISENSOR_TAG_BAROMETER_CALIBRATION_C5:blueCapInt16LittleFromData(data, NSMakeRange(8, 2)),
                                                           TISENSOR_TAG_BAROMETER_CALIBRATION_C6:blueCapInt16LittleFromData(data, NSMakeRange(10, 2)),
                                                           TISENSOR_TAG_BAROMETER_CALIBRATION_C7:blueCapInt16LittleFromData(data, NSMakeRange(12, 2)),
                                                           TISENSOR_TAG_BAROMETER_CALIBRATION_C8:blueCapInt16LittleFromData(data, NSMakeRange(14, 2))};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  NSMutableDictionary* stringValues = [NSMutableDictionary dictionary];
                                                  for(NSString* key in [data allKeys]) {
                                                      [stringValues setObject:[NSString stringWithFormat:@"%d", [[data objectForKey:key] intValue]] forKey:key];
                                                  }
                                                  return stringValues;
                                              }];
                                              [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                  uint16_t uintVals[4];
                                                  uintVals[0] = [[data objectForKey:TISENSOR_TAG_BAROMETER_CALIBRATION_C1] intValue];
                                                  uintVals[1] = [[data objectForKey:TISENSOR_TAG_BAROMETER_CALIBRATION_C2] intValue];
                                                  uintVals[2] = [[data objectForKey:TISENSOR_TAG_BAROMETER_CALIBRATION_C3] intValue];
                                                  uintVals[3] = [[data objectForKey:TISENSOR_TAG_BAROMETER_CALIBRATION_C4] integerValue];
                                                  NSMutableData* uintData = [blueCapLittleFromUnsignedInt16Array(uintVals, 4) mutableCopy];
                                                  int16_t intVals[4];
                                                  intVals[0] = [[data objectForKey:TISENSOR_TAG_BAROMETER_CALIBRATION_C5] intValue];
                                                  intVals[1] = [[data objectForKey:TISENSOR_TAG_BAROMETER_CALIBRATION_C6] intValue];
                                                  intVals[2] = [[data objectForKey:TISENSOR_TAG_BAROMETER_CALIBRATION_C7] intValue];
                                                  intVals[3] = [[data objectForKey:TISENSOR_TAG_BAROMETER_CALIBRATION_C8] intValue];
                                                  [uintData appendData:blueCapLittleFromInt16Array(intVals, 4)];
                                                  return uintData;
                                              }];
                                              characteristicProfile.initialValue =
                                                [characteristicProfile valueFromString:@{TISENSOR_TAG_BAROMETER_CALIBRATION_C1:[NSString stringWithFormat:@"%d", 45697],
                                                                                         TISENSOR_TAG_BAROMETER_CALIBRATION_C2:[NSString stringWithFormat:@"%d", 25592],
                                                                                         TISENSOR_TAG_BAROMETER_CALIBRATION_C3:[NSString stringWithFormat:@"%d", 48894],
                                                                                         TISENSOR_TAG_BAROMETER_CALIBRATION_C4:[NSString stringWithFormat:@"%d", 36147],
                                                                                         TISENSOR_TAG_BAROMETER_CALIBRATION_C5:[NSString stringWithFormat:@"%d", 7001],
                                                                                         TISENSOR_TAG_BAROMETER_CALIBRATION_C6:[NSString stringWithFormat:@"%d", 1990],
                                                                                         TISENSOR_TAG_BAROMETER_CALIBRATION_C7:[NSString stringWithFormat:@"%d", -2369],
                                                                                         TISENSOR_TAG_BAROMETER_CALIBRATION_C8:[NSString stringWithFormat:@"%d", 5542]}];
                                          }];
    }];

#pragma mark - Hygrometer

    [profileManager createServiceWithUUID:TISENSOR_TAG_HYGROMETER_SERVICE_UUID
                                        name:@"TI Hygrometer"
                                  andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                      
                                  [serviceProfile createCharacteristicWithUUID:@"f000aa21-0451-4000-b000-000000000000"
                                                                          name:@"Hygrometer Data"
                                                                    andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                                                        [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                                            NSNumber* tempNumber = blueCapUnsignedInt16LittleFromData(data, NSMakeRange(0, 2));
                                                                            NSNumber* humidNumber = blueCapUnsignedInt16LittleFromData(data, NSMakeRange(2, 2));
                                                                            double temp = -46.86 + 175.72*[tempNumber doubleValue]/65536.0;
                                                                            double humid = -6.0 + 125.0*[humidNumber doubleValue]/65536.0;
                                                                            return @{TISENSOR_TAG_HYGROMETER_TEMPERATURE:[NSNumber numberWithDouble:temp],
                                                                                     TISENSOR_TAG_HYGROMETER_HUMIDITY:[NSNumber numberWithDouble:humid],
                                                                                     TISENSOR_TAG_HYGROMETER_RAW_TEMPERATURE:tempNumber,
                                                                                     TISENSOR_TAG_HYGROMETER_RAW_HUMIDITY:humidNumber};
                                                                        }];
                                                                        [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                                            return @{TISENSOR_TAG_HYGROMETER_TEMPERATURE:
                                                                                         [NSString stringWithFormat:@"%.01f", [[data objectForKey:TISENSOR_TAG_HYGROMETER_TEMPERATURE] floatValue]],
                                                                                     TISENSOR_TAG_HYGROMETER_HUMIDITY:
                                                                                         [NSString stringWithFormat:@"%.01f", [[data objectForKey:TISENSOR_TAG_HYGROMETER_HUMIDITY] floatValue]],
                                                                                     TISENSOR_TAG_HYGROMETER_RAW_TEMPERATURE:
                                                                                         [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_HYGROMETER_RAW_TEMPERATURE] intValue]],
                                                                                     TISENSOR_TAG_HYGROMETER_RAW_HUMIDITY:
                                                                                         [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_HYGROMETER_RAW_HUMIDITY] intValue]]};
                                                                        }];
                                                                        [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                                            uint16_t intVals[2];
                                                                            intVals[0] = [[data objectForKey:TISENSOR_TAG_HYGROMETER_RAW_TEMPERATURE] intValue];
                                                                            intVals[1] = [[data objectForKey:TISENSOR_TAG_HYGROMETER_RAW_HUMIDITY] intValue];
                                                                            return blueCapLittleFromUnsignedInt16Array(intVals, 2);
                                                                        }];
                                                                        characteristicProfile.initialValue = [characteristicProfile valueFromString:@{TISENSOR_TAG_HYGROMETER_RAW_TEMPERATURE:[NSString stringWithFormat:@"%d", 26000],
                                                                                                                                                      TISENSOR_TAG_HYGROMETER_RAW_HUMIDITY:[NSString stringWithFormat:@"%d", 35000]}];
                                                                    }];
                                  
                                  [serviceProfile createCharacteristicWithUUID:@"f000aa22-0451-4000-b000-000000000000"
                                                                          name:@"Hygrometer Enabled"
                                                                    andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                                                        [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_HYGROMETER_ON_VALUE) named:TISENSOR_TAG_HYGROMETER_ON];
                                                                        [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_HYGROMETER_OFF_VALUE) named:TISENSOR_TAG_HYGROMETER_OFF];
                                                                        [characteristicProfile afterDiscovered:^(BlueCapCharacteristic* characteristic) {
                                                                            [characteristic writeValueObject:TISENSOR_TAG_HYGROMETER_ON afterWriteCall:nil];
                                                                        }];
                                                                        characteristicProfile.initialValue = [characteristicProfile valueFromNamedObject:TISENSOR_TAG_HYGROMETER_OFF];
                                                                    }];
                                      
                                  }];

#pragma mark - Sensor Tag Test
    
    [profileManager createServiceWithUUID:TISENSOR_TAG_TEST_SERVICE_UUID
                                     name:@"TI Sensor Tag Test"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                      
        [serviceProfile createCharacteristicWithUUID:@"f000aa61-0451-4000-b000-000000000000"
                                              name:@"Test Data"
                                        andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                            [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                uint8_t testResults = [blueCapUnsignedCharFromData(data, NSMakeRange(0, 1)) unsignedCharValue];
                                                uint8_t test1Result = testResults & (1 << 0);
                                                uint8_t test2Result = testResults & (1 << 1);
                                                uint8_t test3Result = testResults & (1 << 2);
                                                uint8_t test4Result = testResults & (1 << 3);
                                                uint8_t test5Result = testResults & (1 << 4);
                                                uint8_t test6Result = testResults & (1 << 5);
                                                uint8_t test7Result = testResults & (1 << 6);
                                                uint8_t test8Result = testResults & (1 << 7);
                                                return @{TISENSOR_TAG_TEST_1_RESULT:[NSNumber numberWithUnsignedChar:test1Result],
                                                         TISENSOR_TAG_TEST_2_RESULT:[NSNumber numberWithUnsignedChar:test2Result],
                                                         TISENSOR_TAG_TEST_3_RESULT:[NSNumber numberWithUnsignedChar:test3Result],
                                                         TISENSOR_TAG_TEST_4_RESULT:[NSNumber numberWithUnsignedChar:test4Result],
                                                         TISENSOR_TAG_TEST_5_RESULT:[NSNumber numberWithUnsignedChar:test5Result],
                                                         TISENSOR_TAG_TEST_6_RESULT:[NSNumber numberWithUnsignedChar:test6Result],
                                                         TISENSOR_TAG_TEST_7_RESULT:[NSNumber numberWithUnsignedChar:test7Result],
                                                         TISENSOR_TAG_TEST_8_RESULT:[NSNumber numberWithUnsignedChar:test8Result]};
                                            }];
                                            [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                NSMutableDictionary* stringResults = [NSMutableDictionary dictionary];
                                                for (NSString* resultName in [data allKeys]) {
                                                    int result = [[data valueForKey:resultName] intValue];
                                                    if (result == 0) {
                                                        [stringResults setObject:@"FAILED" forKey:resultName];
                                                    } else {
                                                        [stringResults setObject:@"PASSED" forKey:resultName];
                                                    }
                                                }
                                                return stringResults;
                                            }];
                                            [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                uint8_t testVal;
                                                uint8_t intVal = 0;
                                                NSArray* names = [data allKeys];
                                                for (int i = 0; i < 8; i++) {
                                                    NSString* name = [names objectAtIndex:i];
                                                    NSString* result = [data objectForKey:name];
                                                    if ([result isEqualToString:@"PASSED"]) {
                                                        testVal = (1 << i);
                                                    } else {
                                                        testVal = 0;
                                                    }
                                                    intVal = intVal | testVal;
                                                }
                                                return blueCapUnsignedCharToData(intVal);
                                            }];
                                            characteristicProfile.initialValue = [characteristicProfile valueFromString:@{TISENSOR_TAG_TEST_1_RESULT:@"PASSED",
                                                                                                                          TISENSOR_TAG_TEST_2_RESULT:@"FAILED",
                                                                                                                          TISENSOR_TAG_TEST_3_RESULT:@"PASSED",
                                                                                                                          TISENSOR_TAG_TEST_4_RESULT:@"FAILED",
                                                                                                                          TISENSOR_TAG_TEST_5_RESULT:@"PASSED",
                                                                                                                          TISENSOR_TAG_TEST_6_RESULT:@"FAILED",
                                                                                                                          TISENSOR_TAG_TEST_7_RESULT:@"PASSED",
                                                                                                                          TISENSOR_TAG_TEST_8_RESULT:@"FAILED"}];
                                        }];

        [serviceProfile createCharacteristicWithUUID:@"f000aa62-0451-4000-b000-000000000000"
                                              name:@"Test Enabled"
                                        andProfile:^(BlueCapCharacteristicProfile* characteristicProfile ) {
                                            [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_TEST_ON_VALUE) named:TISENSOR_TAG_TEST_ON];
                                            [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_TEST_OFF_VALUE) named:TISENSOR_TAG_TEST_OFF];
                                            characteristicProfile.initialValue = [characteristicProfile valueFromNamedObject:TISENSOR_TAG_TEST_OFF];
                                        }];


    }];

#pragma mark - Key Pressed
    
    [profileManager createServiceWithUUID:TISENSOR_TAG_KEY_PRESSED_SERVICE_UUID
                                     name:@"TI Key Pressed"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                   [serviceProfile createCharacteristicWithUUID:@"ffe1"
                                                                           name:@"Key Pressed State"
                                                                     andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                                                         [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                                             if (data.length > 0) {
                                                                                 return @{TISENSOR_TAG_KEY_PRESSED:blueCapUnsignedCharFromData(data, NSMakeRange(0, 1))};
                                                                             } else {
                                                                                 return @{TISENSOR_TAG_KEY_PRESSED:[NSNumber numberWithInt:0]};
                                                                             }
                                                                         }];
                                                                         [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                                             return @{TISENSOR_TAG_KEY_PRESSED:[NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_KEY_PRESSED] intValue]]};
                                                                         }];
                                                                         [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                                             uint8_t intVal = [[data objectForKey:TISENSOR_TAG_KEY_PRESSED] intValue];
                                                                             return blueCapUnsignedCharToData(intVal);
                                                                         }];
                                                                         characteristicProfile.initialValue = blueCapUnsignedCharToData(0x01);
                                                                     }];
    }];
}

@end
