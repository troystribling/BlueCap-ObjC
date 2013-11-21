//
//  TISensorTagServiceProfile.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCap.h"
#import "TISensorTagServiceProfile.h"

@implementation TISensorTagServiceProfile

+ (void)create {
    
    BlueCapProfileManager* profileManager = [BlueCapProfileManager sharedInstance];
    
#pragma mark - Accelerometer

    [profileManager createServiceWithUUID:@"F000AA10-0451-4000-B000-000000000000"
                                     name:@"TI Accelerometer"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                   
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
                                                               [NSString stringWithFormat:@"%.02f", [[data objectForKey:TISENSOR_TAG_ACCELEROMTER_RAW_X_COMPONENT] floatValue]],
                                                           TISENSOR_TAG_ACCELEROMTER_RAW_Y_COMPONENT:
                                                               [NSString stringWithFormat:@"%.02f", [[data objectForKey:TISENSOR_TAG_ACCELEROMTER_RAW_Y_COMPONENT] floatValue]],
                                                           TISENSOR_TAG_ACCELEROMTER_RAW_Z_COMPONENT:
                                                               [NSString stringWithFormat:@"%.02f", [[data objectForKey:TISENSOR_TAG_ACCELEROMTER_RAW_Z_COMPONENT] floatValue]]};
                                              }];
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
                                          }];
            
        [serviceProfile createCharacteristicWithUUID:@"f000aa13-0451-4000-b000-000000000000"
                                                name:@"Accelerometer Update Period"
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
                                                  int unscaledValue = 10*[blueCapUnsignedCharFromData(data) integerValue];
                                                  return @{TISENSOR_TAG_ACCELEROMETER_UPDATE_PERIOD:[NSNumber numberWithInt:unscaledValue]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return @{TISENSOR_TAG_ACCELEROMETER_UPDATE_PERIOD:[[data objectForKey:TISENSOR_TAG_ACCELEROMETER_UPDATE_PERIOD] stringValue]};
                                              }];
                                          }];
                                   
    }];

#pragma mark - Magnetometer

    [profileManager createServiceWithUUID:@"F000AA30-0451-4000-B000-000000000000"
                                     name:@"TI Magnetometer"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                   
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
                                                               [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_MAGNETOMETER_RAW_X_COMPONENT] integerValue]],
                                                           TISENSOR_TAG_MAGNETOMETER_RAW_Y_COMPONENT:
                                                               [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_MAGNETOMETER_RAW_Y_COMPONENT] integerValue]],
                                                           TISENSOR_TAG_MAGNETOMETER_RAW_Z_COMPONENT:
                                                               [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_MAGNETOMETER_RAW_Z_COMPONENT] integerValue]]};
                                              }];
                                          }];
      
        [serviceProfile createCharacteristicWithUUID:@"f000aa32-0451-4000-b000-000000000000"
                                                name:@"Magnetometer Enabled"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_MAGNETOMETER_ON_VALUE) named:TISENSOR_TAG_MAGNETOMETER_ON];
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_MAGNETOMETER_OFF_VALUE) named:TISENSOR_TAG_MAGNETOMETER_OFF];
                                              [characteristicProfile afterDiscovered:^(BlueCapCharacteristic* characteristic) {
                                                  [characteristic writeValueObject:TISENSOR_TAG_MAGNETOMETER_ON afterWriteCall:nil];
                                              }];
                                          }];

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
                                                int unscaledValue = 10*[blueCapUnsignedCharFromData(data) integerValue];
                                                return @{TISENSOR_TAG_MAGNETOMETER_UPDATE_PERIOD:[NSNumber numberWithInt:unscaledValue]};
                                            }];
                                            [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                return @{TISENSOR_TAG_MAGNETOMETER_UPDATE_PERIOD:[[data objectForKey:TISENSOR_TAG_MAGNETOMETER_UPDATE_PERIOD] stringValue]};
                                            }];
                                        }];
                                   
    }];

#pragma mark - Gyroscope

    [profileManager createServiceWithUUID:@"F000AA50-0451-4000-B000-000000000000"
                                     name:@"TI Gyroscope"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {

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
                                                               [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_GYROSCOPE_RAW_X_COMPONENT] integerValue]],
                                                           TISENSOR_TAG_GYROSCOPE_RAW_Y_COMPONENT:
                                                               [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_GYROSCOPE_RAW_Y_COMPONENT] integerValue]],
                                                           TISENSOR_TAG_GYROSCOPE_RAW_Z_COMPONENT:
                                                               [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_GYROSCOPE_RAW_Z_COMPONENT] integerValue]]};
                                              }];
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
                                          }];
                                   
    }];

#pragma mark - Temperature

    [profileManager createServiceWithUUID:@"F000AA00-0451-4000-B000-000000000000"
                                     name:@"TI IR Temperature Sensor"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {

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
                                                               [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_RAW_TEMPERATURE_AMBIENT] integerValue]],
                                                           TISENSOR_TAG_RAW_TEMPERATURE_OBJECT:
                                                                [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_RAW_TEMPERATURE_OBJECT] integerValue]]};
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"f000aa02-0451-4000-b000-000000000000"
                                                name:@"Temperature Sensor Enabled"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_TEMPERATURE_ON_VALUE) named:TISENSOR_TAG_TEMPERATURE_ON];
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_TEMPERATURE_OFF_VALUE) named:TISENSOR_TAG_TEMPERATURE_OFF];
                                              [characteristicProfile afterDiscovered:^(BlueCapCharacteristic* characteristic) {
                                                  [characteristic writeValueObject:TISENSOR_TAG_TEMPERATURE_ON afterWriteCall:nil];
                                              }];
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

    [profileManager createServiceWithUUID:@"F000AA40-0451-4000-B000-000000000000"
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
                                                               [NSString stringWithFormat:@"%.02f", [[data objectForKey:TISENSOR_TAG_BAROMETER_RAW_TEMPERATURE] floatValue]],
                                                           TISENSOR_TAG_BAROMETER_RAW_PRESSURE:
                                                               [NSString stringWithFormat:@"%.02f", [[data objectForKey:TISENSOR_TAG_BAROMETER_RAW_PRESSURE] floatValue]]};
                                              }];
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
                                                      [stringValues setObject:[NSString stringWithFormat:@"%d", [[data objectForKey:key] integerValue]] forKey:key];
                                                  }
                                                  return stringValues;
                                              }];
                                          }];
    }];

#pragma mark - Hygrometer

    [profileManager createServiceWithUUID:@"F000AA20-0451-4000-B000-000000000000"
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
                                                                                         [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_HYGROMETER_RAW_TEMPERATURE] integerValue]],
                                                                                     TISENSOR_TAG_HYGROMETER_RAW_HUMIDITY:
                                                                                         [NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_HYGROMETER_RAW_HUMIDITY] integerValue]]};
                                                                        }];
                                                                        [characteristicProfile serializeString:^NSData*(NSDictionary* _data) {
                                                                            uint16_t intData[2];
                                                                            intData[0] = [[_data objectForKey:TISENSOR_TAG_HYGROMETER_RAW_TEMPERATURE] integerValue];
                                                                            intData[1] = [[_data objectForKey:TISENSOR_TAG_HYGROMETER_RAW_HUMIDITY] integerValue];
                                                                            return [NSData dataWithBytes:&intData length:4];
                                                                        }];
                                                                        characteristicProfile.initialValue = [characteristicProfile valueFromString:@{TISENSOR_TAG_HYGROMETER_RAW_TEMPERATURE:[NSString stringWithFormat:@"%d", 2600],
                                                                                                                                                      TISENSOR_TAG_HYGROMETER_RAW_HUMIDITY:[NSString stringWithFormat:@"%d", 3500]}];
                                                                    }];
                                  
                                  [serviceProfile createCharacteristicWithUUID:@"f000aa22-0451-4000-b000-000000000000"
                                                                          name:@"Hygrometer Enabled"
                                                                    andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                                                        [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_HYGROMETER_ON_VALUE) named:TISENSOR_TAG_HYGROMETER_ON];
                                                                        [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_HYGROMETER_OFF_VALUE) named:TISENSOR_TAG_HYGROMETER_OFF];
                                                                        characteristicProfile.initialValue = [characteristicProfile valueFromNamedObject:TISENSOR_TAG_HYGROMETER_OFF];
                                                                        [characteristicProfile afterDiscovered:^(BlueCapCharacteristic* characteristic) {
                                                                            [characteristic writeValueObject:TISENSOR_TAG_HYGROMETER_ON afterWriteCall:nil];
                                                                        }];
                                                                    }];
                                      
                                  }];

#pragma mark - Sensor Tag Test
    
    [profileManager createServiceWithUUID:@"F000AA60-0451-4000-B000-000000000000"
                                     name:@"TI Sensor Tag Test"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                      
        [serviceProfile createCharacteristicWithUUID:@"f000aa61-0451-4000-b000-000000000000"
                                              name:@"Test Data"
                                        andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                            [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                uint8_t testResults = [blueCapUnsignedCharFromData(data) unsignedCharValue];
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
                                                    int result = [[data valueForKey:resultName] integerValue];
                                                    if (result == 0) {
                                                        [stringResults setObject:@"FAILED" forKey:resultName];
                                                    } else {
                                                        [stringResults setObject:@"PASSED" forKey:resultName];
                                                    }
                                                }
                                                return stringResults;
                                            }];
                                        }];

        [serviceProfile createCharacteristicWithUUID:@"f000aa62-0451-4000-b000-000000000000"
                                              name:@"Test Enabled"
                                        andProfile:^(BlueCapCharacteristicProfile* characteristicProfile ) {
                                            [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_TEST_ON_VALUE) named:TISENSOR_TAG_TEST_ON];
                                            [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_TEST_OFF_VALUE) named:TISENSOR_TAG_TEST_OFF];
                                        }];


    }];

#pragma mark - Key Pressed
    
    [profileManager createServiceWithUUID:@"ffe0"
                                     name:@"TI Key Pressed"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                   [serviceProfile createCharacteristicWithUUID:@"ffe1"
                                                                           name:@"Key Pressed State"
                                                                     andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                                                         [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                                             if (data.length > 0) {
                                                                                 return @{TISENSOR_TAG_KEY_PRESSED:blueCapUnsignedCharFromData(data)};
                                                                             } else {
                                                                                 return @{TISENSOR_TAG_KEY_PRESSED:[NSNumber numberWithInt:0]};
                                                                             }
                                                                         }];
                                                                         [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                                             return @{TISENSOR_TAG_KEY_PRESSED:[NSString stringWithFormat:@"%d", [[data objectForKey:TISENSOR_TAG_KEY_PRESSED] integerValue]]};
                                                                         }];
                                                                     }];
    }];
}

@end
