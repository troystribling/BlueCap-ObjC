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
    
    BlueCapCentralManager* centralManager = [BlueCapCentralManager sharedInstance];
    
#pragma mark - Accelerometer

    [centralManager createServiceWithUUID:@"F000AA10-0451-4000-B000-000000000000"
                                     name:@"Accelerometer"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                   
        [serviceProfile createCharacteristicWithUUID:@"f000aa11-0451-4000-b000-000000000000"
                                                name:@"Accelerometer Data"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  NSNumber* accxNumber = blueCapCharFromData(data, NSMakeRange(0,1));
                                                  NSNumber* accyNumber = blueCapCharFromData(data, NSMakeRange(1,1));
                                                  NSNumber* acczNumber = blueCapCharFromData(data, NSMakeRange(2,1));
                                                  float accxScaled = -[accxNumber floatValue]/64.0f;
                                                  float accyScaled = -[accyNumber floatValue]/64.0f;
                                                  float acczScaled = [acczNumber floatValue]/64.0f;
                                                  return @{TISENSOR_TAG_ACCELEROMTER_VALUE_X_COMPONENT:[NSNumber numberWithFloat:accxScaled],
                                                           TISENSOR_TAG_ACCELEROMTER_VALUE_Y_COMPONENT:[NSNumber numberWithFloat:accyScaled],
                                                           TISENSOR_TAG_ACCELEROMTER_VALUE_Z_COMPONENT:[NSNumber numberWithFloat:acczScaled]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return @{TISENSOR_TAG_ACCELEROMTER_VALUE_X_COMPONENT:
                                                               [NSString stringWithFormat:@"%.02f", [[data objectForKey:TISENSOR_TAG_ACCELEROMTER_VALUE_X_COMPONENT] floatValue]],
                                                           TISENSOR_TAG_ACCELEROMTER_VALUE_Y_COMPONENT:
                                                               [NSString stringWithFormat:@"%.02f", [[data objectForKey:TISENSOR_TAG_ACCELEROMTER_VALUE_Y_COMPONENT] floatValue]],
                                                           TISENSOR_TAG_ACCELEROMTER_VALUE_Z_COMPONENT:
                                                               [NSString stringWithFormat:@"%.02f", [[data objectForKey:TISENSOR_TAG_ACCELEROMTER_VALUE_Z_COMPONENT] floatValue]]};
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
                                                  [characteristic writeValueNamed:TISENSOR_TAG_ACCELEROMETER_ON afterWriteCall:nil];
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

    [centralManager createServiceWithUUID:@"F000AA30-0451-4000-B000-000000000000"
                                     name:@"Magnetometer"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                   
        [serviceProfile createCharacteristicWithUUID:@"f000aa31-0451-4000-b000-000000000000"
                                                name:@"Magnetometer Data"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                          }];
      
        [serviceProfile createCharacteristicWithUUID:@"f000aa32-0451-4000-b000-000000000000"
                                                name:@"Magnetometer Enabled"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_MAGNETOMETER_ON_VALUE) named:TISENSOR_TAG_MAGNETOMETER_ON];
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_MAGNETOMETER_OFF_VALUE) named:TISENSOR_TAG_MAGNETOMETER_OFF];
                                              [characteristicProfile afterDiscovered:^(BlueCapCharacteristic* characteristic) {
                                                  [characteristic writeValueNamed:TISENSOR_TAG_MAGNETOMETER_ON afterWriteCall:nil];
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"f000aa33-0451-4000-b000-000000000000"
                                              name:@"Magnetometer Update Period"
                                        andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                        }];
                                   
    }];

#pragma mark - Gyroscope

    [centralManager createServiceWithUUID:@"F000AA50-0451-4000-B000-000000000000"
                                     name:@"Gyroscope"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {

        [serviceProfile createCharacteristicWithUUID:@"f000aa51-0451-4000-b000-000000000000"
                                                name:@"Gyroscope Data"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
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
                                                  [characteristic writeValueNamed:TISENSOR_TAG_GYROSCOPE_XYZ_AXIS_ON afterWriteCall:nil];
                                              }];
                                          }];
                                   
    }];

#pragma mark - Temperature

    [centralManager createServiceWithUUID:@"F000AA00-0451-4000-B000-000000000000"
                                     name:@"IR Temperature Sensor"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {

        [serviceProfile createCharacteristicWithUUID:@"f000aa01-0451-4000-b000-000000000000"
                                                name:@"Temperature Data"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  double ambient = [blueCapInt16FromData(data, NSMakeRange(0, 2)) doubleValue];
                                                  double object = [blueCapInt16FromData(data, NSMakeRange(2, 2)) doubleValue];
                                                  double tRef = 298.15;
                                                  double tAmb = ambient/128.0;
                                                  return @{TISENSOR_TAG_TEMPERATURE_AMBIENT:[NSNumber numberWithDouble:ambient],
                                                           TISENSOR_TAG_TEMPERATURE_OBJECT:[NSNumber numberWithDouble:object]};
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"f000aa02-0451-4000-b000-000000000000"
                                                name:@"Temperature Sensor Enabled"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_TEMPERATURE_ON_VALUE) named:TISENSOR_TAG_TEMPERATURE_ON];
                                              [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_TEMPERATURE_OFF_VALUE) named:TISENSOR_TAG_TEMPERATURE_OFF];
                                              [characteristicProfile afterDiscovered:^(BlueCapCharacteristic* characteristic) {
                                                  [characteristic writeValueNamed:TISENSOR_TAG_TEMPERATURE_ON afterWriteCall:nil];
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

    [centralManager createServiceWithUUID:@"F000AA40-0451-4000-B000-000000000000"
                                     name:@"Barometer"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                
        [serviceProfile createCharacteristicWithUUID:@"f000aa41-0451-4000-b000-000000000000"
                                                name:@"Barometer Data"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{TISENSOR_TAG_BAROMETER_RAW_TEMPERATURE:blueCapInt16FromData(data, NSMakeRange(0, 2)),
                                                           TISENSOR_TAG_BAROMETER_RAW_PRESSURE:blueCapUnsignedInt16FromData(data, NSMakeRange(2, 2))};
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
                                                  [characteristic writeValueNamed:TISENSOR_TAG_BAROMETER_ON afterWriteCall:^(BlueCapCharacteristic* characteristic, NSError* error) {
                                                      [characteristic writeValueNamed:TISENSOR_TAG_BAROMETER_READ_CALIBRATION afterWriteCall:nil];
                                                  }];
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"f000aa43-0451-4000-b000-000000000000"
                                                name:@"Barometer Calibration Data"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{TISENSOR_TAG_BAROMETER_CALIBRATION_C1:blueCapUnsignedInt16FromData(data, NSMakeRange(0, 2)),
                                                           TISENSOR_TAG_BAROMETER_CALIBRATION_C2:blueCapUnsignedInt16FromData(data, NSMakeRange(2, 2)),
                                                           TISENSOR_TAG_BAROMETER_CALIBRATION_C3:blueCapUnsignedInt16FromData(data, NSMakeRange(4, 2)),
                                                           TISENSOR_TAG_BAROMETER_CALIBRATION_C4:blueCapUnsignedInt16FromData(data, NSMakeRange(6, 2)),
                                                           TISENSOR_TAG_BAROMETER_CALIBRATION_C5:blueCapInt16FromData(data, NSMakeRange(8, 2)),
                                                           TISENSOR_TAG_BAROMETER_CALIBRATION_C6:blueCapInt16FromData(data, NSMakeRange(10, 2)),
                                                           TISENSOR_TAG_BAROMETER_CALIBRATION_C7:blueCapInt16FromData(data, NSMakeRange(12, 2)),
                                                           TISENSOR_TAG_BAROMETER_CALIBRATION_C8:blueCapInt16FromData(data, NSMakeRange(14, 2))};
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

    [centralManager createServiceWithUUID:@"F000AA20-0451-4000-B000-000000000000"
                                        name:@"Hygrometer"
                                  andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                      
                                  [serviceProfile createCharacteristicWithUUID:@"f000aa21-0451-4000-b000-000000000000"
                                                                          name:@"Hygrometer"
                                                                    andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                                                    }];
                                  
                                  [serviceProfile createCharacteristicWithUUID:@"f000aa22-0451-4000-b000-000000000000"
                                                                          name:@"Hygrometer Enabled"
                                                                    andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                                                        [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_HYGROMETER_ON_VALUE) named:TISENSOR_TAG_HYGROMETER_ON];
                                                                        [characteristicProfile setValue:blueCapUnsignedCharToData(TISENSOR_TAG_HYGROMETER_OFF_VALUE) named:TISENSOR_TAG_HYGROMETER_OFF];
                                                                        [characteristicProfile afterDiscovered:^(BlueCapCharacteristic* characteristic) {
                                                                            [characteristic writeValueNamed:TISENSOR_TAG_HYGROMETER_ON afterWriteCall:nil];
                                                                        }];
                                                                    }];
                                      
                                  }];

    [centralManager createServiceWithUUID:@"F000AA60-0451-4000-B000-000000000000"
                                     name:@"TISensorTag Test"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                      
        [serviceProfile createCharacteristicWithUUID:@"f000aa61-0451-4000-b000-000000000000"
                                              name:@"Test Data"
                                        andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                        }];

        [serviceProfile createCharacteristicWithUUID:@"f000aa62-0451-4000-b000-000000000000"
                                              name:@"Test On/Off"
                                        andProfile:^(BlueCapCharacteristicProfile* characteristicProfile ) {
                                        }];

    }];

}

@end
