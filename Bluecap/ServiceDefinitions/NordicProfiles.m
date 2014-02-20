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

    [profileManager createServiceWithUUID:@"2f0a0003-69aa-f316-3e78-4194989a6c1a" name:@"Device Temperature" andProfile:^(BlueCapServiceProfile* serviceProfile) {
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
    
    
}

@end
