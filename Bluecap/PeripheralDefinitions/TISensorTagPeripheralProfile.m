//
//  TISensorTagPeripheralProfile.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCap.h"
#import "TISensorTagPeripheralProfile.h"

@implementation TISensorTagPeripheralProfile

+ (void)create {
    [[BlueCapCentralManager sharedInstance] createPeripheralWithName:@"TI BLE Sensor Tag" andProfile:^(BlueCapPeripheralProfile* peripheralProfile) {
        
        [peripheralProfile createServiceWithUUID:@"180a"
                                            name:@"Device Information"
                                      andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                      }];

        [peripheralProfile createServiceWithUUID:@"ffe0"
                                            name:@"Key Pressed"
                                      andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                      }];

        [peripheralProfile createServiceWithUUID:@"F000AA10-0451-4000-B000-000000000000"
                                            name:@"Accelerometer"
                                        andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                      }];

        [peripheralProfile createServiceWithUUID:@"F000AA30-0451-4000-B000-000000000000"
                                               name:@"Magnetometer"
                                      andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                      }];
        
        [peripheralProfile createServiceWithUUID:@"F000AA50-0451-4000-B000-000000000000"
                                               name:@"Gyroscope"
                                      andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                      }];

        [peripheralProfile createServiceWithUUID:@"F000AA00-0451-4000-B000-000000000000"
                                               name:@"IR Temperature Sensor"
                                      andProfile:^(BlueCapServiceProfile* serviceProfile) {

                                          [serviceProfile createCharacteristicWithUUID:@"f000aa01-0451-4000-b000-000000000000"
                                                                                     name:@"Temperature"
                                                                            andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                            }];
                                          
                                          [serviceProfile createCharacteristicWithUUID:@"f000aa02-0451-4000-b000-000000000000"
                                                                                     name:@"Temperature Configure"
                                                                            andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                            }];
                                          
                                      }];
        
        [peripheralProfile createServiceWithUUID:@"F000AA40-0451-4000-B000-000000000000"
                                            name:@"Barometer"
                                      andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                      }];

        [peripheralProfile createServiceWithUUID:@"F000AA20-0451-4000-B000-000000000000"
                                            name:@"Humidity Sensor"
                                      andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                      }];

        [peripheralProfile createServiceWithUUID:@"F000AA60-0451-4000-B000-000000000000"
                                            name:@"Test Service"
                                      andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                      }];

    }];
}

@end
