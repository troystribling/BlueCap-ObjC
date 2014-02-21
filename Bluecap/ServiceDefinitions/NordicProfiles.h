//
//  NordicProfiles.h
//  BlueCap
//
//  Created by Troy Stribling on 2/20/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NORDIC_DEVICE_TEMPERATURE       @"Temperature"

#define NORDIC_BLE_ADDRESS_1                                          @"Address-1"
#define NORDIC_BLE_ADDRESS_2                                          @"Address-2"
#define NORDIC_BLE_ADDRESS_3                                          @"Address-3"
#define NORDIC_BLE_ADDRESS_4                                          @"Address-4"
#define NORDIC_BLE_ADDRESS_5                                          @"Address-5"
#define NORDIC_BLE_ADDRESS_6                                          @"Address-6"

#define NORDIC_BLE_ADDRESS_TYPE_UNKNOWN                             @"Unknown"
#define NORDIC_BLE_ADDRESS_TYPE_UNKNOWN_VALUE                       0x00
#define NORDIC_BLE_ADDRESS_TYPE_PUBLIC                              @"Public"
#define NORDIC_BLE_ADDRESS_TYPE_PUBLIC_VALUE                        0x01
#define NORDIC_BLE_ADDRESS_TYPE_RANDOM_STATIC                       @"Random Static"
#define NORDIC_BLE_ADDRESS_TYPE_RANDOM_STATIC_VALUE                 0x02
#define NORDIC_BLE_ADDRESS_TYPE_RANDOM_PRIVATE_RESOLVABLE           @"Random Private Resolvable"
#define NORDIC_BLE_ADDRESS_TYPE_RANDOM_PRIVATE_RESOLVABLE_VALUE     0x03
#define NORDIC_BLE_ADDRESS_TYPE_RANDOM_PRIVATE_UNRESOLVABLE         @"Random Private Unresolvable"
#define NORDIC_BLE_ADDRESS_TYPE_RANDOM_PRIVATE_UNRESOLVABLE_VALUE   0x04

@interface NordicProfiles : NSObject

+ (void)create;

@end
