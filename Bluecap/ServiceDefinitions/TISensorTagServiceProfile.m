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
    
#pragma mark -
#pragma mark Accelerometer

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
                                                name:@"Accelerometer On/Off"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile serializeValueNamed:TISENSOR_TAG_ACCELEROMETER_ON usingBlock:^NSData* {
                                                  uint8_t data = TISENSOR_TAG_ACCELEROMETER_ON_VALUE;
                                                  return [NSData dataWithBytes:&data length:1];
                                              }];
                                              [characteristicProfile serializeValueNamed:TISENSOR_TAG_ACCELEROMETER_OFF usingBlock:^NSData* {
                                                  uint8_t data = TISENSOR_TAG_ACCELEROMETER_OFF_VALUE;
                                                  return [NSData dataWithBytes:&data length:1];
                                              }];
                                              [characteristicProfile afterDiscovered:^(BlueCapCharacteristic* characteristic) {
                                                  [characteristic writeValueNamed:TISENSOR_TAG_ACCELEROMETER_ON afterWriteCall:nil];
                                              }];
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return  @{TISENSOR_TAG_ACCELEROMTER_ENABLED:[NSNumber numberWithBool:blueCapBooleanFromData(data)]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  NSString* stringVal = @"NO";
                                                  if ([[data objectForKey:TISENSOR_TAG_ACCELEROMTER_ENABLED] boolValue]) {
                                                      stringVal = @"YES";
                                                  }
                                                  return @{TISENSOR_TAG_ACCELEROMTER_ENABLED:stringVal};
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
                                                  } else if (value > 0xff) {
                                                      value = 0xff;
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

#pragma mark -
#pragma mark Magnetometer

    [centralManager createServiceWithUUID:@"F000AA30-0451-4000-B000-000000000000"
                                     name:@"Magnetometer"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                   
        [serviceProfile createCharacteristicWithUUID:@"f000aa31-0451-4000-b000-000000000000"
                                                name:@"Magnetometer Data"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                          }];
      
        [serviceProfile createCharacteristicWithUUID:@"f000aa32-0451-4000-b000-000000000000"
                                                name:@"Magnetometer On/Off"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile serializeValueNamed:TISENSOR_TAG_MAGNETOMETER_ON usingBlock:^NSData* {
                                                  uint8_t data = TISENSOR_TAG_MAGNETOMETER_ON_VALUE;
                                                  return [NSData dataWithBytes:&data length:1];
                                              }];
                                              [characteristicProfile serializeValueNamed:TISENSOR_TAG_MAGNETOMETER_OFF usingBlock:^NSData* {
                                                  uint8_t data = TISENSOR_TAG_MAGNETOMETER_OFF_VALUE;
                                                  return [NSData dataWithBytes:&data length:1];
                                              }];
                                              [characteristicProfile afterDiscovered:^(BlueCapCharacteristic* characteristic) {
                                                  [characteristic writeValueNamed:TISENSOR_TAG_MAGNETOMETER_ON afterWriteCall:nil];
                                              }];
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return  @{TISENSOR_TAG_MAGNETOMETER_ENABLED:[NSNumber numberWithBool:blueCapBooleanFromData(data)]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  NSString* stringVal = @"NO";
                                                  if ([[data objectForKey:TISENSOR_TAG_MAGNETOMETER_ENABLED] boolValue]) {
                                                      stringVal = @"YES";
                                                  }
                                                  return @{TISENSOR_TAG_MAGNETOMETER_ENABLED:stringVal};
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"f000aa33-0451-4000-b000-000000000000"
                                              name:@"Magnetometer Update Period"
                                        andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                        }];
                                   
    }];

#pragma mark -
#pragma mark Gyroscope

    [centralManager createServiceWithUUID:@"F000AA50-0451-4000-B000-000000000000"
                                     name:@"Gyroscope"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {

        [serviceProfile createCharacteristicWithUUID:@"f000aa51-0451-4000-b000-000000000000"
                                                name:@"Gyroscope Data"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"f000aa52-0451-4000-b000-000000000000"
                                                name:@"Gyroscope On/Off"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile serializeValueNamed:TISENSOR_TAG_GYROSCOPE_X_AXIS_ON usingBlock:^NSData* {
                                                  uint8_t data = TISENSOR_TAG_GYROSCOPE_X_AXIS_ON_VALUE;
                                                  return [NSData dataWithBytes:&data length:1];
                                              }];
                                              [characteristicProfile serializeValueNamed:TISENSOR_TAG_GYROSCOPE_Y_AXIS_ON usingBlock:^NSData* {
                                                  uint8_t data = TISENSOR_TAG_GYROSCOPE_Y_AXIS_ON_VALUE;
                                                  return [NSData dataWithBytes:&data length:1];
                                              }];
                                              [characteristicProfile serializeValueNamed:TISENSOR_TAG_GYROSCOPE_XY_AXIS_ON usingBlock:^NSData* {
                                                  uint8_t data = TISENSOR_TAG_GYROSCOPE_XY_AXIS_ON_VALUE;
                                                  return [NSData dataWithBytes:&data length:1];
                                              }];
                                              [characteristicProfile serializeValueNamed:TISENSOR_TAG_GYROSCOPE_Z_AXIS_ON usingBlock:^NSData* {
                                                  uint8_t data = TISENSOR_TAG_GYROSCOPE_Z_AXIS_ON_VALUE;
                                                  return [NSData dataWithBytes:&data length:1];
                                              }];
                                              [characteristicProfile serializeValueNamed:TISENSOR_TAG_GYROSCOPE_XZ_AXIS_ON usingBlock:^NSData* {
                                                  uint8_t data = TISENSOR_TAG_GYROSCOPE_XZ_AXIS_ON_VALUE;
                                                  return [NSData dataWithBytes:&data length:1];
                                              }];
                                              [characteristicProfile serializeValueNamed:TISENSOR_TAG_GYROSCOPE_YZ_AXIS_ON usingBlock:^NSData* {
                                                  uint8_t data = TISENSOR_TAG_GYROSCOPE_YZ_AXIS_ON_VALUE;
                                                  return [NSData dataWithBytes:&data length:1];
                                              }];
                                              [characteristicProfile serializeValueNamed:TISENSOR_TAG_GYROSCOPE_XYZ_AXIS_ON usingBlock:^NSData* {
                                                  uint8_t data = TISENSOR_TAG_GYROSCOPE_XYZ_AXIS_ON_VALUE;
                                                  return [NSData dataWithBytes:&data length:1];
                                              }];
                                              [characteristicProfile serializeValueNamed:TISENSOR_TAG_GYROSCOPE_OFF usingBlock:^NSData* {
                                                  uint8_t data = TISENSOR_TAG_GYROSCOPE_OFF_VALUE;
                                                  return [NSData dataWithBytes:&data length:1];
                                              }];
                                              [characteristicProfile afterDiscovered:^(BlueCapCharacteristic* characteristic) {
                                                  [characteristic writeValueNamed:TISENSOR_TAG_GYROSCOPE_XYZ_AXIS_ON afterWriteCall:nil];
                                              }];
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return  @{TISENSOR_TAG_GYROSCOPE_ENABLED:[NSNumber numberWithBool:blueCapBooleanFromData(data)]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  NSString* stringVal = @"NO";
                                                  if ([[data objectForKey:TISENSOR_TAG_GYROSCOPE_ENABLED] boolValue]) {
                                                      stringVal = @"YES";
                                                  }
                                                  return @{TISENSOR_TAG_GYROSCOPE_ENABLED:stringVal};
                                              }];
                                          }];
                                   
    }];

#pragma mark -
#pragma mark Temperature

    [centralManager createServiceWithUUID:@"F000AA00-0451-4000-B000-000000000000"
                                     name:@"IR Temperature Sensor"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {

        [serviceProfile createCharacteristicWithUUID:@"f000aa01-0451-4000-b000-000000000000"
                                                name:@"Temperature"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"f000aa02-0451-4000-b000-000000000000"
                                                name:@"Temperature Sensor On/Off"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile serializeValueNamed:TISENSOR_TAG_TEMPERATURE_ON usingBlock:^NSData* {
                                                  uint8_t data = TISENSOR_TAG_TEMPERATURE_ON_VALUE;
                                                  return [NSData dataWithBytes:&data length:1];
                                              }];
                                              [characteristicProfile serializeValueNamed:TISENSOR_TAG_TEMPERATURE_OFF usingBlock:^NSData* {
                                                  uint8_t data = TISENSOR_TAG_TEMPERATURE_OFF_VALUE;
                                                  return [NSData dataWithBytes:&data length:1];
                                              }];
                                              [characteristicProfile afterDiscovered:^(BlueCapCharacteristic* characteristic) {
                                                  [characteristic writeValueNamed:TISENSOR_TAG_TEMPERATURE_ON afterWriteCall:nil];
                                              }];
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return  @{TISENSOR_TAG_TEMPERATURE_ENABLED:[NSNumber numberWithBool:blueCapBooleanFromData(data)]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  NSString* stringVal = @"NO";
                                                  if ([[data objectForKey:TISENSOR_TAG_TEMPERATURE_ENABLED] boolValue]) {
                                                      stringVal = @"YES";
                                                  }
                                                  return @{TISENSOR_TAG_TEMPERATURE_ENABLED:stringVal};
                                              }];
                                          }];
    }];

#pragma mark -
#pragma mark Barometer

    [centralManager createServiceWithUUID:@"F000AA40-0451-4000-B000-000000000000"
                                     name:@"Barometer"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                
        [serviceProfile createCharacteristicWithUUID:@"f000aa41-0451-4000-b000-000000000000"
                                                name:@"Barometer Data"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"f000aa42-0451-4000-b000-000000000000"
                                                name:@"Barometer On/Off"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile serializeValueNamed:TISENSOR_TAG_BAROMETER_ON usingBlock:^NSData* {
                                                  uint8_t data = TISENSOR_TAG_BAROMETER_ON_VALUE;
                                                  return [NSData dataWithBytes:&data length:1];
                                              }];
                                              [characteristicProfile serializeValueNamed:TISENSOR_TAG_BAROMETER_OFF usingBlock:^NSData* {
                                                  uint8_t data = TISENSOR_TAG_BAROMETER_OFF_VALUE;
                                                  return [NSData dataWithBytes:&data length:1];
                                              }];
                                              [characteristicProfile serializeValueNamed:TISENSOR_TAG_BAROMETER_READ_CALIBRATION usingBlock:^NSData* {
                                                  uint8_t data = TISENSOR_TAG_BAROMETER_READ_CALIBRATION_VALUE;
                                                  return [NSData dataWithBytes:&data length:1];
                                              }];
                                              [characteristicProfile afterDiscovered:^(BlueCapCharacteristic* characteristic) {
                                                  [characteristic writeValueNamed:TISENSOR_TAG_BAROMETER_ON afterWriteCall:^(BlueCapCharacteristicData* data, NSError* error) {
                                                      [data.characteristic writeValueNamed:TISENSOR_TAG_BAROMETER_READ_CALIBRATION afterWriteCall:nil];
                                                  }];
                                              }];
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return  @{TISENSOR_TAG_BAROMETER_ENABLED:[NSNumber numberWithBool:blueCapBooleanFromData(data)]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  NSString* stringVal = @"NO";
                                                  if ([[data objectForKey:TISENSOR_TAG_BAROMETER_ENABLED] boolValue]) {
                                                      stringVal = @"YES";
                                                  }
                                                  return @{TISENSOR_TAG_BAROMETER_ENABLED:stringVal};
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"f000aa43-0451-4000-b000-000000000000"
                                                name:@"Barometer Calibration"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                          }];
                                   
    }];

#pragma mark -
#pragma mark Hygrometer

    [centralManager createServiceWithUUID:@"F000AA20-0451-4000-B000-000000000000"
                                        name:@"Hygrometer"
                                  andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                      
                                  [serviceProfile createCharacteristicWithUUID:@"f000aa21-0451-4000-b000-000000000000"
                                                                          name:@"Hygrometer"
                                                                    andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                                                    }];
                                  
                                  [serviceProfile createCharacteristicWithUUID:@"f000aa22-0451-4000-b000-000000000000"
                                                                          name:@"Hygrometer On/Off"
                                                                    andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                                                        [characteristicProfile serializeValueNamed:TISENSOR_TAG_HYGROMETER_ON usingBlock:^NSData* {
                                                                            uint8_t data = TISENSOR_TAG_HYGROMETER_ON_VALUE;
                                                                            return [NSData dataWithBytes:&data length:1];
                                                                        }];
                                                                        [characteristicProfile serializeValueNamed:TISENSOR_TAG_HYGROMETER_OFF usingBlock:^NSData* {
                                                                            uint8_t data = TISENSOR_TAG_HYGROMETER_OFF_VALUE;
                                                                            return [NSData dataWithBytes:&data length:1];
                                                                        }];
                                                                        [characteristicProfile afterDiscovered:^(BlueCapCharacteristic* characteristic) {
                                                                            [characteristic writeValueNamed:TISENSOR_TAG_HYGROMETER_ON afterWriteCall:nil];
                                                                        }];
                                                                        [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                                            return  @{TISENSOR_TAG_HYGROMETER_ENABLED:[NSNumber numberWithBool:blueCapBooleanFromData(data)]};
                                                                        }];
                                                                        [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                                            NSString* stringVal = @"NO";
                                                                            if ([[data objectForKey:TISENSOR_TAG_HYGROMETER_ENABLED] boolValue]) {
                                                                                stringVal = @"YES";
                                                                            }
                                                                            return @{TISENSOR_TAG_HYGROMETER_ENABLED:stringVal};
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
