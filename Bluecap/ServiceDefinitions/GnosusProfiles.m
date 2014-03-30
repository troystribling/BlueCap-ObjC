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
    
    [profileManager createServiceWithUUID:GNOSUS_HELLO_WORLD_SERVICE_UUID
                                     name:@"Hello World"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                    [serviceProfile createCharacteristicWithUUID:GNOSUS_HELLO_WORLD_GREETING_CHARACTERISTIC_UUID name:@"Greeting" andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
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
                                    [serviceProfile createCharacteristicWithUUID:GNOSUS_HELLO_WORLD_UPDATE_PERIOD_CHARACTERISTIC_UUID name:@"Update Period" andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
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
    
    [profileManager createServiceWithUUID:GNOSUS_LOCATION_SERVICE_UUID
                                     name:@"Location"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                   [serviceProfile createCharacteristicWithUUID:GNOSUS_LOCATION_LATITUDE_AND_LONGITUDE_CHARACTERISTIC_UUID
                                                                           name:@"Latitude and Longitude"
                                                                     andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                                                         characteristicProfile.properties = CBCharacteristicPropertyRead | CBCharacteristicPropertyWrite;
                                                                         [characteristicProfile serializeObject:^NSData*(id data) {
                                                                             NSNumber* latitude = [data objectForKey:GNOSUS_LOCATION_LATITUDE];
                                                                             NSNumber* longitude = [data objectForKey:GNOSUS_LOCATION_LATITUDE];
                                                                             int16_t location[2];
                                                                             location[0] = (int16_t)(100.0*[latitude floatValue]);
                                                                             location[1] = (int16_t)(100.0*[longitude floatValue]);
                                                                             return blueCapBigFromInt16Array(location, 2);
                                                                         }];
                                                                         [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                                             float latitude = [blueCapInt16BigFromData(data, NSMakeRange(0, 2)) floatValue] / 100.0;
                                                                             float longitude = [blueCapInt16BigFromData(data, NSMakeRange(2, 2)) floatValue] / 100.0;
                                                                             return @{GNOSUS_LOCATION_LATITUDE:[NSNumber numberWithFloat:latitude],
                                                                                      GNOSUS_LOCATION_LONGITUDE:[NSNumber numberWithFloat:longitude]};
                                                                         }];
                                                                         [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                                             return @{GNOSUS_LOCATION_LATITUDE:[[data objectForKey:GNOSUS_LOCATION_LATITUDE] stringValue],
                                                                                      GNOSUS_LOCATION_LONGITUDE:[[data objectForKey:GNOSUS_LOCATION_LONGITUDE] stringValue]};
                                                                         }];
                                                                         [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                                             return [characteristicProfile valueFromObject:@{GNOSUS_LOCATION_LATITUDE:[NSNumber numberWithInt:[[data objectForKey:GNOSUS_LOCATION_LATITUDE] floatValue]],
                                                                                                                             GNOSUS_LOCATION_LONGITUDE:[NSNumber numberWithInt:[[data objectForKey:GNOSUS_LOCATION_LONGITUDE] floatValue]]}];
                                                                         }];
                                                                         characteristicProfile.initialValue = [characteristicProfile valueFromString:@{GNOSUS_LOCATION_LATITUDE:[NSString stringWithFormat:@"%d", 3776],
                                                                                                                                                       GNOSUS_LOCATION_LONGITUDE:[NSString stringWithFormat:@"%d", -12242]}];
                                                                     }];
                               }];
    [profileManager createServiceWithUUID:GNOSUS_EPOC_TIME_SERVICE_UUID
                                     name:@"Epoc Time"
                               andProfile:^(BlueCapServiceProfile* serviceProfile) {
                                   [serviceProfile createCharacteristicWithUUID:GNOSUS_EPOC_TIME_TIME_CHARACTERISTIC_UUID
                                                                           name:@"Time"
                                                                     andProfile:^(BlueCapCharacteristicProfile* characteristicProfile) {
                                                                         characteristicProfile.properties = CBCharacteristicPropertyRead | CBCharacteristicPropertyWrite | CBCharacteristicPropertyNotify;
                                                                         [characteristicProfile serializeObject:^NSData*(id data) {
                                                                             uint16_t time = [data intValue];
                                                                             return blueCapBigFromInt16(time);
                                                                         }];
                                                                         [characteristicProfile deserializeData:^NSDictionary*(NSData* data) {
                                                                             return @{GNOSUS_EPOC_TIME_TIME:blueCapUnsignedInt16BigFromData(data, NSMakeRange(0, 2))};
                                                                         }];
                                                                         [characteristicProfile stringValue:^NSDictionary*(NSDictionary* data) {
                                                                             return @{GNOSUS_EPOC_TIME_TIME:[[data objectForKey:GNOSUS_EPOC_TIME_TIME] stringValue]};
                                                                         }];
                                                                         [characteristicProfile serializeString:^NSData*(NSDictionary* data) {
                                                                             return [characteristicProfile valueFromObject:[NSNumber numberWithInt:[[data objectForKey:GNOSUS_EPOC_TIME_TIME] intValue]]];
                                                                         }];
                                                                         characteristicProfile.initialValue = [characteristicProfile valueFromString:@{GNOSUS_EPOC_TIME_TIME:[NSString stringWithFormat:@"%d", 1395597813]}];
                                                                     }];
                               }];

}

@end
