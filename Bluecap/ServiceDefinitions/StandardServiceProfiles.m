//
//  StandardServiceProfiles.m
//  BlueCap
//
//  Created by Troy Stribling on 10/4/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCap.h"
#import "StandardServiceProfiles.h"

@implementation StandardServiceProfiles

+ (void)create {

    BlueCapCentralManager* centralManager = [BlueCapCentralManager sharedInstance];

#pragma mark -
#pragma mark Device Information

    [centralManager createServiceWithUUID:@"180a"
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

#pragma mark -
#pragma mark Key Pressed

    [centralManager createServiceWithUUID:@"ffe0"
                                     name:@"Key Pressed"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                  
        [serviceProfile createCharacteristicWithUUID:@"ffe1"
                                                name:@"Key Pressed State"
                                          andProfile:^(BlueCapCharacteristicProfile* chracteristicProfile) {
                                          }];

        }];


}

@end
