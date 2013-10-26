//
//  BLEGATTProfiles.m
//  BlueCap
//
//  Created by Troy Stribling on 10/4/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCap.h"
#import "BLEGATTProfiles.h"

@implementation BLEGATTProfiles

+ (void)create {

    BlueCapCentralManager* centralManager = [BlueCapCentralManager sharedInstance];

#pragma mark - Device Information

    [centralManager createServiceWithUUID:@"180a"
                                     name:@"Device Information"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                  
        [serviceProfile createCharacteristicWithUUID:@"2a23"
                                                name:@"System ID"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLE_GATT_DEVICE_INFORMATION_SYSTEM_ID:@"Coming Soon"};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return @{BLE_GATT_DEVICE_INFORMATION_SYSTEM_ID:@"Coming Soon"};
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"2a24"
                                                name:@"Model Number"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLE_GATT_DEVICE_INFORMATION_MODEL_NUMBER:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return data;
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"2a25"
                                                name:@"Serial Number"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLE_GATT_DEVICE_INFORMATION_SERIAL_NUMBER:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return data;
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"2a26"
                                                name:@"Firmware Revision"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLE_GATT_DEVICE_INFORMATION_FIRMWARE_REVISION:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return data;
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"2a27"
                                                name:@"Hardware Revision"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLE_GATT_DEVICE_INFORMATION_HARDWARE_REVISION:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return data;
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"2a28"
                                                name:@"Software Revision"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLE_GATT_DEVICE_INFORMATION_SOFTWARE_REVISION:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return data;
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"2a29"
                                                name:@"Manufacturer Name"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLE_GATT_DEVICE_INFORMATION_SOFTWARE_REVISION:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return data;
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"2a2a"
                                                name:@"Certification Data"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLE_GATT_DEVICE_INFORMATION_MANUFACTURER_NAME:@"Coming Soon"};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return data;
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"2a50"
                                                name:@"PnP ID"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLE_GATT_DEVICE_INFORMATION_PNP_ID:@"Coming Soon"};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return data;
                                              }];
                                          }];

        }];

#pragma mark - Key Pressed

    [centralManager createServiceWithUUID:@"ffe0"
                                     name:@"Key Pressed"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                  
        [serviceProfile createCharacteristicWithUUID:@"ffe1"
                                                name:@"Key Pressed State"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                          }];

        }];


}

@end
