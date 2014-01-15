//
//  GnosusProfiles.m
//  BlueCap
//
//  Created by Troy Stribling on 1/11/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

#import "GnosusProfiles.h"
#import "BlueCap.h"

#define MAX_HELLO_WORLD_COUNT   10

@implementation GnosusProfiles

+ (void)create {

    BlueCapProfileManager* profileManager = [BlueCapProfileManager sharedInstance];
    
#pragma mark - Hello World
    
    [profileManager createServiceWithUUID:@"2f0a0000-69aa-f316-3e78-4194989a6c1a" name:@"Hello World" andProfile:^(BlueCapServiceProfile* serviceProfile) {
        [serviceProfile createCharacteristicWithUUID:@"2f0a0001-69aa-f316-3e78-4194989a6c1a" name:@"Greeting" andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
            characteristicProfile.properties = CBCharacteristicPropertyRead;
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
        [serviceProfile createCharacteristicWithUUID:@"2f0a0002-69aa-f316-3e78-4194989a6c1a" name:@"Count" andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
            NSData* (^serializeUINT8)(uint8_t) = ^(uint8_t value) {
                if (value > MAX_HELLO_WORLD_COUNT) {
                    value = MAX_HELLO_WORLD_COUNT;
                }
                return blueCapUnsignedCharToData(value);
            };
            characteristicProfile.properties = CBCharacteristicPropertyRead;
            [characteristicProfile serializeObject:^NSData*(id data) {
                uint8_t value = (uint8_t)[data intValue];
                return serializeUINT8(value);
            }];
            [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                int value = [blueCapUnsignedCharFromData(data) intValue];
                return @{GNOSUS_HELLO_WORLD_COUNT:[NSNumber numberWithInt:value]};
            }];
            [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                return @{GNOSUS_HELLO_WORLD_COUNT:[[data objectForKey:GNOSUS_HELLO_WORLD_COUNT] stringValue]};
            }];
            [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                uint8_t value = (uint8_t)[[data objectForKey:GNOSUS_HELLO_WORLD_COUNT] intValue];
                return serializeUINT8(value);
            }];
            characteristicProfile.initialValue = blueCapUnsignedCharToData(0x01);
        }];
    }];
    
}

@end
