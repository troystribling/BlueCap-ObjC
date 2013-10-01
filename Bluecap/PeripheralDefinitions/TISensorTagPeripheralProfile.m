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
                                          
                                      [serviceProfile createCharacteristicWithUUID:@"2a23"
                                                                              name:@"System ID"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];

                                      [serviceProfile createCharacteristicWithUUID:@"2a24"
                                                                              name:@"Model Number"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];

                                      [serviceProfile createCharacteristicWithUUID:@"2a25"
                                                                              name:@"Serial Number"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];

                                      [serviceProfile createCharacteristicWithUUID:@"2a26"
                                                                              name:@"Firmware Revision"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];
                                          
                                      [serviceProfile createCharacteristicWithUUID:@"2a27"
                                                                              name:@"Hardware Revision"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];
                                          
                                      [serviceProfile createCharacteristicWithUUID:@"2a28"
                                                                              name:@"Software Revision"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];

                                      [serviceProfile createCharacteristicWithUUID:@"2a29"
                                                                              name:@"Manufacturer Name"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];

                                      [serviceProfile createCharacteristicWithUUID:@"2a2a"
                                                                              name:@"Certification Data"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];

                                      [serviceProfile createCharacteristicWithUUID:@"2a50"
                                                                              name:@"PnP ID"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];

                                      }];

        [peripheralProfile createServiceWithUUID:@"ffe0"
                                            name:@"Key Pressed"
                                      andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                          
                                      [serviceProfile createCharacteristicWithUUID:@"ffe1"
                                                                              name:@"Key Pressed State"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];

                                      }];

        [peripheralProfile createServiceWithUUID:@"F000AA10-0451-4000-B000-000000000000"
                                            name:@"Accelerometer"
                                        andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                            
                                            
                                        [serviceProfile createCharacteristicWithUUID:@"f000aa11-0451-4000-b000-000000000000"
                                                                                name:@"Accelerometer Data"
                                                                          andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                          }];

                                        [serviceProfile createCharacteristicWithUUID:@"f000aa12-0451-4000-b000-000000000000"
                                                                                name:@"Accelerometer Configure"
                                                                          andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                          }];
                                            
                                        [serviceProfile createCharacteristicWithUUID:@"f000aa13-0451-4000-b000-000000000000"
                                                                                name:@"Accelerometer Update Period"
                                                                          andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                          }];


                                      }];

        [peripheralProfile createServiceWithUUID:@"F000AA30-0451-4000-B000-000000000000"
                                               name:@"Magnetometer"
                                      andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                          
                                          
                                      [serviceProfile createCharacteristicWithUUID:@"f000aa31-0451-4000-b000-000000000000"
                                                                              name:@"Magnetometer Data"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];
                                      
                                      [serviceProfile createCharacteristicWithUUID:@"f000aa32-0451-4000-b000-000000000000"
                                                                              name:@"Magnetometer Configure"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];
                                      
                                      [serviceProfile createCharacteristicWithUUID:@"f000aa33-0451-4000-b000-000000000000"
                                                                              name:@"Magnetometer Update Period"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];

                                      }];
        
        [peripheralProfile createServiceWithUUID:@"F000AA50-0451-4000-B000-000000000000"
                                               name:@"Gyroscope"
                                      andProfile:^(BlueCapServiceProfile* serviceProfile) {

                                      [serviceProfile createCharacteristicWithUUID:@"f000aa51-0451-4000-b000-000000000000"
                                                                              name:@"Gyroscope Data"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];
                                      
                                      [serviceProfile createCharacteristicWithUUID:@"f000aa52-0451-4000-b000-000000000000"
                                                                              name:@"Gyroscope Configure"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];

                                      }];

        [peripheralProfile createServiceWithUUID:@"F000AA00-0451-4000-B000-000000000000"
                                               name:@"IR Temperature Sensor"
                                      andProfile:^(BlueCapServiceProfile* serviceProfile) {

                                      [serviceProfile createCharacteristicWithUUID:@"f000aa01-0451-4000-b000-000000000000"
                                                                              name:@"Temperature"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];
                                      
                                      [serviceProfile createCharacteristicWithUUID:@"f000aa02-0451-4000-b000-000000000000"
                                                                              name:@"Temperature Sensor Configure"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];

                                      }];
        
        [peripheralProfile createServiceWithUUID:@"F000AA40-0451-4000-B000-000000000000"
                                            name:@"Barometer"
                                      andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                    
                                      [serviceProfile createCharacteristicWithUUID:@"f000aa41-0451-4000-b000-000000000000"
                                                                              name:@"Barometer Data"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];
                                      
                                      [serviceProfile createCharacteristicWithUUID:@"f000aa42-0451-4000-b000-000000000000"
                                                                              name:@"Barometer Configure"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];
                                      
                                      [serviceProfile createCharacteristicWithUUID:@"f000aa43-0451-4000-b000-000000000000"
                                                                              name:@"Barometer Calibration"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];
                                          
                                      }];

        [peripheralProfile createServiceWithUUID:@"F000AA20-0451-4000-B000-000000000000"
                                            name:@"Hygrometer"
                                      andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                          
                                      [serviceProfile createCharacteristicWithUUID:@"f000aa21-0451-4000-b000-000000000000"
                                                                              name:@"Hygrometer"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];
                                      
                                      [serviceProfile createCharacteristicWithUUID:@"f000aa22-0451-4000-b000-000000000000"
                                                                              name:@"Hygrometer Configure"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];
                                          
                                      }];

        [peripheralProfile createServiceWithUUID:@"F000AA60-0451-4000-B000-000000000000"
                                            name:@"Test Service"
                                      andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                          
                                      [serviceProfile createCharacteristicWithUUID:@"f000aa61-0451-4000-b000-000000000000"
                                                                              name:@"Test Data"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];
                                      
                                      [serviceProfile createCharacteristicWithUUID:@"f000aa62-0451-4000-b000-000000000000"
                                                                              name:@"Test Configure"
                                                                        andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                                                        }];

                                      }];

    }];
}

@end
