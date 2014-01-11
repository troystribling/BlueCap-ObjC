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
                                  
        [serviceProfile createCharacteristicWithUUID:@"2a24"
                                                name:@"Model Number"
                                          andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                              [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                  return @{BLESIG_GATT_DEVICE_INFORMATION_MODEL_NUMBER:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                                              }];
                                              [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                  return data;
                                              }];
                                              [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                  return [[data objectForKey:BLESIG_GATT_DEVICE_INFORMATION_MODEL_NUMBER] dataUsingEncoding:NSUTF8StringEncoding];
                                              }];
                                              characteristicProfile.initialValue = [@"Model Number" dataUsingEncoding:NSUTF8StringEncoding];
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
                                              [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                  return [[data objectForKey:BLESIG_GATT_DEVICE_INFORMATION_SERIAL_NUMBER] dataUsingEncoding:NSUTF8StringEncoding];
                                              }];
                                              characteristicProfile.initialValue = [@"Serial Number" dataUsingEncoding:NSUTF8StringEncoding];
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
                                              [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                  return [[data objectForKey:BLESIG_GATT_DEVICE_INFORMATION_FIRMWARE_REVISION] dataUsingEncoding:NSUTF8StringEncoding];
                                              }];
                                              characteristicProfile.initialValue = [@"Firmware Revision" dataUsingEncoding:NSUTF8StringEncoding];
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
                                              [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                  return [[data objectForKey:BLESIG_GATT_DEVICE_INFORMATION_HARDWARE_REVISION] dataUsingEncoding:NSUTF8StringEncoding];
                                              }];
                                              characteristicProfile.initialValue = [@"Hardware Revision" dataUsingEncoding:NSUTF8StringEncoding];
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
                                              [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                  return [[data objectForKey:BLESIG_GATT_DEVICE_INFORMATION_SOFTWARE_REVISION] dataUsingEncoding:NSUTF8StringEncoding];
                                              }];
                                              characteristicProfile.initialValue = [@"Software Revision" dataUsingEncoding:NSUTF8StringEncoding];
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
                                              [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                  return [[data objectForKey:BLESIG_GATT_DEVICE_INFORMATION_MANUFACTURER_NAME] dataUsingEncoding:NSUTF8StringEncoding];
                                              }];
                                              characteristicProfile.initialValue = [@"gnos.us" dataUsingEncoding:NSUTF8StringEncoding];
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
                                                  uint8_t value = (uint8_t)[[data objectForKey:BLESIG_GATT_BATTERY_LEVEL] intValue];
                                                  return blueCapUnsignedCharToData(value);
                                              }];
                                              characteristicProfile.initialValue = [characteristicProfile valueFromString:@{BLESIG_GATT_BATTERY_LEVEL:@"100"}];
                                          }];
    }];

    [profileManager createServiceWithUUID:@"1805" name:@"Current Time" andProfile:^(BlueCapServiceProfile* serviceProfile) {
    }];
    
    [profileManager createServiceWithUUID:@"1804" name:@"Tx Power" andProfile:^(BlueCapServiceProfile* serviceProfile) {
        [serviceProfile createCharacteristicWithUUID:@"2a07" name:@"Tx Power Level" andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
            characteristicProfile.properties = CBCharacteristicPropertyRead;
            [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                int value = [blueCapCharFromData(data, NSMakeRange(0,1)) intValue];
                return @{BLESIG_GATT_TX_POWER_LEVEL: [NSNumber numberWithInt:value]};
            }];
            [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                return @{BLESIG_GATT_TX_POWER_LEVEL:[[data objectForKey:BLESIG_GATT_TX_POWER_LEVEL] stringValue]};
            }];
            [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                int8_t value = (int8_t)[[data objectForKey:BLESIG_GATT_TX_POWER_LEVEL] intValue];
                return blueCapCharToData(value);
            }];
            characteristicProfile.initialValue = [characteristicProfile valueFromString:@{BLESIG_GATT_TX_POWER_LEVEL:[NSString stringWithFormat:@"%d", -40]}];
        }];
    }];
}

@end
