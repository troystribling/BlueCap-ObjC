//
//  NordicProfiles.m
//  BlueCap
//
//  Created by Troy Stribling on 2/20/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

#import "NordicProfiles.h"
#import "BlueCap.h"

@implementation NordicProfiles

+ (void)create {

    BlueCapProfileManager* profileManager = [BlueCapProfileManager sharedInstance];

    [profileManager createServiceWithUUID:@"2f0a0003-69aa-f316-3e78-4194989a6c1a" name:@"Nordic Device Temperature" andProfile:^(BlueCapServiceProfile* serviceProfile) {
        [serviceProfile createCharacteristicWithUUID:@"2f0a0004-69aa-f316-3e78-4194989a6c1a" name:@"Temperature" andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
            characteristicProfile.properties = CBCharacteristicPropertyRead | CBCharacteristicPropertyNotify;
            [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                int scaledVal = [blueCapInt16BigFromData(data, NSMakeRange(0, 2)) intValue] / 4;
                return @{NORDIC_DEVICE_TEMPERATURE:[NSNumber numberWithInt:scaledVal]};
            }];
            [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                return @{NORDIC_DEVICE_TEMPERATURE:[[data objectForKey:NORDIC_DEVICE_TEMPERATURE] stringValue]};
            }];
            [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                int16_t value = 4*(int16_t)[[data objectForKey:NORDIC_DEVICE_TEMPERATURE] intValue];
                return blueCapBigFromInt16(value);
            }];
            characteristicProfile.initialValue = [characteristicProfile valueFromString:@{NORDIC_DEVICE_TEMPERATURE:[NSString stringWithFormat:@"%d", 100]}];
        }];
    }];
    
    [profileManager createServiceWithUUID:@"2f0a0005-69aa-f316-3e78-4194989a6c1a" name:@"Nordic BLE Address" andProfile:^(BlueCapServiceProfile* serviceProfile) {
        [serviceProfile createCharacteristicWithUUID:@"2f0a0006-69aa-f316-3e78-4194989a6c1a" name:@"Address" andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
            characteristicProfile.properties = CBCharacteristicPropertyRead;
            [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                NSNumber* addr6 = blueCapUnsignedCharFromData(data, NSMakeRange(0, 1));
                NSNumber* addr5 = blueCapUnsignedCharFromData(data, NSMakeRange(1, 1));
                NSNumber* addr4 = blueCapUnsignedCharFromData(data, NSMakeRange(2, 1));
                NSNumber* addr3 = blueCapUnsignedCharFromData(data, NSMakeRange(3, 1));
                NSNumber* addr2 = blueCapUnsignedCharFromData(data, NSMakeRange(4, 1));
                NSNumber* addr1 = blueCapUnsignedCharFromData(data, NSMakeRange(5, 1));
                return @{NORDIC_BLE_ADDRESS_1:addr1,
                         NORDIC_BLE_ADDRESS_2:addr2,
                         NORDIC_BLE_ADDRESS_3:addr3,
                         NORDIC_BLE_ADDRESS_4:addr4,
                         NORDIC_BLE_ADDRESS_5:addr5,
                         NORDIC_BLE_ADDRESS_6:addr6};
            }];
            [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                return @{NORDIC_BLE_ADDRESS_1:[NSString stringWithFormat:@"%d", [[data objectForKey:NORDIC_BLE_ADDRESS_1] intValue]],
                         NORDIC_BLE_ADDRESS_2:[NSString stringWithFormat:@"%d", [[data objectForKey:NORDIC_BLE_ADDRESS_2] intValue]],
                         NORDIC_BLE_ADDRESS_3:[NSString stringWithFormat:@"%d", [[data objectForKey:NORDIC_BLE_ADDRESS_3] intValue]],
                         NORDIC_BLE_ADDRESS_4:[NSString stringWithFormat:@"%d", [[data objectForKey:NORDIC_BLE_ADDRESS_4] intValue]],
                         NORDIC_BLE_ADDRESS_5:[NSString stringWithFormat:@"%d", [[data objectForKey:NORDIC_BLE_ADDRESS_5] intValue]],
                         NORDIC_BLE_ADDRESS_6:[NSString stringWithFormat:@"%d", [[data objectForKey:NORDIC_BLE_ADDRESS_6] intValue]]};
            }];
            [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                uint8_t vals[6];
                vals[0] = [[data objectForKey:NORDIC_BLE_ADDRESS_6] intValue];
                vals[1] = [[data objectForKey:NORDIC_BLE_ADDRESS_5] intValue];
                vals[2] = [[data objectForKey:NORDIC_BLE_ADDRESS_4] intValue];
                vals[3] = [[data objectForKey:NORDIC_BLE_ADDRESS_3] intValue];
                vals[4] = [[data objectForKey:NORDIC_BLE_ADDRESS_2] intValue];
                vals[5] = [[data objectForKey:NORDIC_BLE_ADDRESS_1] intValue];
                return blueCapUnsignedCharArrayToData(vals, 6);
            }];
            characteristicProfile.initialValue = [characteristicProfile valueFromString:@{NORDIC_BLE_ADDRESS_1:[NSString stringWithFormat:@"%d", 10],
                                                                                          NORDIC_BLE_ADDRESS_2:[NSString stringWithFormat:@"%d", 11],
                                                                                          NORDIC_BLE_ADDRESS_3:[NSString stringWithFormat:@"%d", 12],
                                                                                          NORDIC_BLE_ADDRESS_4:[NSString stringWithFormat:@"%d", 13],
                                                                                          NORDIC_BLE_ADDRESS_5:[NSString stringWithFormat:@"%d", 14],
                                                                                          NORDIC_BLE_ADDRESS_6:[NSString stringWithFormat:@"%d", 15]}];
        }];
        [serviceProfile createCharacteristicWithUUID:@"2f0a0007-69aa-f316-3e78-4194989a6c1a" name:@"Address Type" andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
            characteristicProfile.properties = CBCharacteristicPropertyRead;
            [characteristicProfile setValue:blueCapUnsignedCharToData(NORDIC_BLE_ADDRESS_TYPE_UNKNOWN_VALUE) named:NORDIC_BLE_ADDRESS_TYPE_UNKNOWN];
            [characteristicProfile setValue:blueCapUnsignedCharToData(NORDIC_BLE_ADDRESS_TYPE_PUBLIC_VALUE) named:NORDIC_BLE_ADDRESS_TYPE_PUBLIC];
            [characteristicProfile setValue:blueCapUnsignedCharToData(NORDIC_BLE_ADDRESS_TYPE_RANDOM_STATIC_VALUE) named:NORDIC_BLE_ADDRESS_TYPE_RANDOM_STATIC];
            [characteristicProfile setValue:blueCapUnsignedCharToData(NORDIC_BLE_ADDRESS_TYPE_RANDOM_PRIVATE_RESOLVABLE_VALUE) named:NORDIC_BLE_ADDRESS_TYPE_RANDOM_PRIVATE_RESOLVABLE];
            [characteristicProfile setValue:blueCapUnsignedCharToData(NORDIC_BLE_ADDRESS_TYPE_RANDOM_PRIVATE_UNRESOLVABLE_VALUE) named:NORDIC_BLE_ADDRESS_TYPE_RANDOM_PRIVATE_UNRESOLVABLE];
            characteristicProfile.initialValue = [characteristicProfile valueFromNamedObject:NORDIC_BLE_ADDRESS_TYPE_PUBLIC];
        }];
    }];
}

@end
