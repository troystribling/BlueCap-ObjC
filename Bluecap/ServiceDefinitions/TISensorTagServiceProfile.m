//
//  TISensorTagServiceProfile.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCap.h"
#import "TISensorTagServiceProfile.h"

NSNumber* charFromData(NSData* data, NSRange range) {
    int8_t val;
    [data getBytes:&val range:range];
    return [NSNumber numberWithChar:val];
}

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
                                              [characteristicProfile deserialize:^NSDictionary*(NSData* data) {
                                                  NSNumber* accxNumber = charFromData(data, NSMakeRange(0,1));
                                                  NSNumber* accyNumber = charFromData(data, NSMakeRange(1,1));
                                                  NSNumber* acczNumber = charFromData(data, NSMakeRange(2,1));
                                                  float accxScaled = [accxNumber floatValue]/64.0f;
                                                  float accyScaled = [accyNumber floatValue]/64.0f;
                                                  float acczScaled = [acczNumber floatValue]/64.0f;
                                                  return [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                                                              [NSNumber numberWithFloat:accxScaled],
                                                                                              [NSNumber numberWithFloat:accyScaled],
                                                                                              [NSNumber numberWithFloat:acczScaled], nil]
                                                                                     forKeys:[NSArray arrayWithObjects:
                                                                                              TISENSOR_TAG_ACCELEROMTER_VALUE_X_COMPONENT,
                                                                                              TISENSOR_TAG_ACCELEROMTER_VALUE_Y_COMPONENT,
                                                                                              TISENSOR_TAG_ACCELEROMTER_VALUE_Z_COMPONENT, nil]];
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                                                              [[data objectForKey:TISENSOR_TAG_ACCELEROMTER_VALUE_X_COMPONENT] stringValue],
                                                                                              [[data objectForKey:TISENSOR_TAG_ACCELEROMTER_VALUE_Y_COMPONENT] stringValue],
                                                                                              [[data objectForKey:TISENSOR_TAG_ACCELEROMTER_VALUE_Z_COMPONENT] stringValue], nil]
                                                                                     forKeys:[NSArray arrayWithObjects:
                                                                                              TISENSOR_TAG_ACCELEROMTER_VALUE_X_COMPONENT,
                                                                                              TISENSOR_TAG_ACCELEROMTER_VALUE_Y_COMPONENT,
                                                                                              TISENSOR_TAG_ACCELEROMTER_VALUE_Z_COMPONENT, nil]];
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
                                              [characteristicProfile deserialize:^NSDictionary*(NSData* data) {
                                                  uint8_t value;
                                                  [data getBytes:&value length:1];
                                                  BOOL boolValue = YES;
                                                  if (value == 0) {
                                                      boolValue = NO;
                                                  }
                                                  return  [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:boolValue]
                                                                                      forKey:TISENSOR_TAG_ACCELEROMTER_ENABLED];
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  NSString* stringVal = @"NO";
                                                  if ([[data objectForKey:TISENSOR_TAG_ACCELEROMTER_ENABLED] boolValue]) {
                                                      stringVal = @"YES";
                                                  }
                                                  return [NSDictionary dictionaryWithObject:stringVal
                                                                                     forKey:TISENSOR_TAG_ACCELEROMTER_ENABLED];
                                              }];
                                          }];
            
        [serviceProfile createCharacteristicWithUUID:@"f000aa13-0451-4000-b000-000000000000"
                                                name:@"Accelerometer Update Period"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
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
                                                                    }];
                                      
                                  }];

    [centralManager createServiceWithUUID:@"F000AA60-0451-4000-B000-000000000000"
                                     name:@"TISensorTag Test Service"
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
