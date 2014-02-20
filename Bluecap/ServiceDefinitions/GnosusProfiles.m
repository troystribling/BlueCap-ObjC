//
//  GnosusProfiles.m
//  BlueCap
//
//  Created by Troy Stribling on 1/11/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

#import "GnosusProfiles.h"
#import "BlueCap.h"

@implementation GnosusProfiles

+ (void)create {

    BlueCapProfileManager* profileManager = [BlueCapProfileManager sharedInstance];
    
#pragma mark - Hello World
    
    [profileManager createServiceWithUUID:@"2f0a0000-69aa-f316-3e78-4194989a6c1a" name:@"Hello World" andProfile:^(BlueCapServiceProfile* serviceProfile) {
        [serviceProfile createCharacteristicWithUUID:@"2f0a0001-69aa-f316-3e78-4194989a6c1a" name:@"Greeting" andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
            characteristicProfile.properties = CBCharacteristicPropertyRead | CBCharacteristicPropertyNotify;
            [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                return @{GNOSUS_HELLO_WORLD_GREETING:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
            }];
            [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                return data;
            }];
            [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                return [[data objectForKey:GNOSUS_HELLO_WORLD_GREETING] dataUsingEncoding:NSUTF8StringEncoding];
            }];
            characteristicProfile.initialValue = [@"Hello" dataUsingEncoding:NSUTF8StringEncoding];
        }];
        [serviceProfile createCharacteristicWithUUID:@"2f0a0002-69aa-f316-3e78-4194989a6c1a" name:@"Update Period" andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
            characteristicProfile.properties = CBCharacteristicPropertyRead;
            [characteristicProfile serializeObject:^NSData*(id data) {
                uint16_t value = (uint16_t)[data intValue];
                return blueCapBigFromUnsignedInt16(value);
            }];
            [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                return @{GNOSUS_HELLO_WORLD_UPDATE_PERIOD:blueCapUnsignedInt16BigFromData(data, NSMakeRange(0, 2))};
            }];
            [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                return @{GNOSUS_HELLO_WORLD_UPDATE_PERIOD:[[data objectForKey:GNOSUS_HELLO_WORLD_UPDATE_PERIOD] stringValue]};
            }];
            [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                uint16_t value = (uint16_t)[[data objectForKey:GNOSUS_HELLO_WORLD_UPDATE_PERIOD] intValue];
                return blueCapBigFromUnsignedInt16(value);
            }];
            characteristicProfile.initialValue = [characteristicProfile valueFromString:@{GNOSUS_HELLO_WORLD_UPDATE_PERIOD:[NSString stringWithFormat:@"%d", 5000]}];
        }];
    }];
    
}

@end
