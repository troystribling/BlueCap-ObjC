//
//  TISensorTagPeripheralDefinition.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCap.h"
#import "TISensorTagPeripheralDefinition.h"

@implementation TISensorTagPeripheralDefinition

+ (void)create {
    [[BlueCapCentralManager sharedInstance] createPeripheralWithName:@"TI BLE Sensor Tag" andDefinition:^(BlueCapPeripheralDefinition* peripheralDefinition) {
        
        [peripheralDefinition createServiceWithUUID:@"F000AA10-0451-4000-B000-000000000000"
                                               name:@"Accelerometer"
                                      andDefinition:^(BlueCapServiceDefinition* serviceDefinition) {
                                      }];

        [peripheralDefinition createServiceWithUUID:@"F000AA30-0451-4000-B000-000000000000"
                                               name:@"Magnetometer"
                                      andDefinition:^(BlueCapServiceDefinition* serviceDefinition) {
                                      }];
        
        [peripheralDefinition createServiceWithUUID:@"F000AA50-0451-4000-B000-000000000000"
                                               name:@"Gyroscope"
                                      andDefinition:^(BlueCapServiceDefinition* serviceDefinition) {
                                      }];

        [peripheralDefinition createServiceWithUUID:@"F000AA00-0451-4000-B000-000000000000"
                                               name:@"IR Temperature Sensor"
                                      andDefinition:^(BlueCapServiceDefinition* serviceDefinition) {
                                      }];
        
        [peripheralDefinition createServiceWithUUID:@"F000AA40-0451-4000-B000-000000000000"
                                               name:@"Barometer"
                                      andDefinition:^(BlueCapServiceDefinition* serviceDefinition) {
                                      }];

        [peripheralDefinition createServiceWithUUID:@"F000AA20-0451-4000-B000-000000000000"
                                               name:@"Humidity Sensor"
                                      andDefinition:^(BlueCapServiceDefinition* serviceDefinition) {
                                      }];

        [peripheralDefinition createServiceWithUUID:@"F000AA20-0451-4000-B000-000000000000"
                                               name:@"Humidity Sensor"
                                      andDefinition:^(BlueCapServiceDefinition* serviceDefinition) {
                                      }];

    }];
}

@end
