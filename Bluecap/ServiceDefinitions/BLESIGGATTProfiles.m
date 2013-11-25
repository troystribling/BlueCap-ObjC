//
//  BLEGSIGATTProfiles.m
//  BlueCap
//
//  Created by Troy Stribling on 10/4/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCap.h"
#import "BLESIGGATTProfiles.h"

@implementation BLESIGGATTProfiles

+ (void)create {

    BlueCapProfileManager* profileManager = [BlueCapProfileManager sharedInstance];

#pragma mark - Device Information

    [profileManager createServiceWithUUID:@"180a"
                                     name:@"Device Information"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                  
        [serviceProfile createCharacteristicWithUUID:@"2a23"
                                                name:@"System ID"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLESIG_GATT_DEVICE_INFORMATION_SYSTEM_ID:@"Coming Soon"};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return @{BLESIG_GATT_DEVICE_INFORMATION_SYSTEM_ID:@"Coming Soon"};
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"2a24"
                                                name:@"Model Number"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLESIG_GATT_DEVICE_INFORMATION_MODEL_NUMBER:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return data;
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"2a25"
                                                name:@"Serial Number"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLESIG_GATT_DEVICE_INFORMATION_SERIAL_NUMBER:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return data;
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"2a26"
                                                name:@"Firmware Revision"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLESIG_GATT_DEVICE_INFORMATION_FIRMWARE_REVISION:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return data;
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"2a27"
                                                name:@"Hardware Revision"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLESIG_GATT_DEVICE_INFORMATION_HARDWARE_REVISION:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return data;
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"2a28"
                                                name:@"Software Revision"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLESIG_GATT_DEVICE_INFORMATION_SOFTWARE_REVISION:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return data;
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"2a29"
                                                name:@"Manufacturer Name"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLESIG_GATT_DEVICE_INFORMATION_MANUFACTURER_NAME:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return data;
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"2a2a"
                                                name:@"Certification Data"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLESIG_GATT_DEVICE_INFORMATION_MANUFACTURER_NAME:@"Coming Soon"};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return data;
                                              }];
                                          }];

        [serviceProfile createCharacteristicWithUUID:@"2a50"
                                                name:@"PnP ID"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLESIG_GATT_DEVICE_INFORMATION_PNP_ID:@"Coming Soon"};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return data;
                                              }];
                                          }];

        }];
    
    [profileManager createServiceWithUUID:@"180f"
                                     name:@"Battery"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
        
        [serviceProfile createCharacteristicWithUUID:@"2a19"
                                                name:@"Battery Level"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              characteristicProfile.properties = CBCharacteristicPropertyNotify | CBCharacteristicPropertyRead;
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLESIG_GATT_BATTERY_LEVEL:[NSNumber numberWithInt:[blueCapUnsignedCharFromData(data) integerValue]]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return @{BLESIG_GATT_BATTERY_LEVEL:[[data objectForKey:BLESIG_GATT_BATTERY_LEVEL] stringValue]};
                                              }];
                                              [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                  uint8_t value = (uint8_t)[[data objectForKey:BLESIG_GATT_BATTERY_LEVEL] integerValue];
                                                  return blueCapUnsignedCharToData(value);
                                              }];
                                              characteristicProfile.initialValue = [characteristicProfile valueFromString:@{BLESIG_GATT_BATTERY_LEVEL:@"100"}];
                                          }];
    }];

    [profileManager createServiceWithUUID:@"1805" name:@"Current Time" andProfile:^(BlueCapServiceProfile* serviceProfile) {
    }];
}

@end
