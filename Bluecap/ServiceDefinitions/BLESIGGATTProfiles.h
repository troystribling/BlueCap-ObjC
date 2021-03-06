//
//  BLESIGGATTProfiles.h
//  BlueCap
//
//  Created by Troy Stribling on 10/4/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Service UUIDs -

#define BLESIG_GATT_DEVICE_INFORMATION_SERVICE_UUID     @"180a"
#define BLESIG_GATT_BATTERY_LEVEL_SERVICE_UUID          @"180f"
#define BLESIG_GATT_CURRENT_TIME_SERVICE_UUID           @"1805"
#define BLESIG_GATT_CURRENT_TX_POWER_LEVEL_UUID         @"1804"

#pragma mark - Device Information

#define BLESIG_GATT_DEVICE_INFORMATION_SYSTEM_ID                @"System ID"
#define BLESIG_GATT_DEVICE_INFORMATION_MODEL_NUMBER             @"Model Number"
#define BLESIG_GATT_DEVICE_INFORMATION_SERIAL_NUMBER            @"Serial Number"
#define BLESIG_GATT_DEVICE_INFORMATION_FIRMWARE_REVISION        @"Firmware Revision"
#define BLESIG_GATT_DEVICE_INFORMATION_HARDWARE_REVISION        @"Hardware Revision"
#define BLESIG_GATT_DEVICE_INFORMATION_SOFTWARE_REVISION        @"Software Revision"
#define BLESIG_GATT_DEVICE_INFORMATION_MANUFACTURER_NAME        @"Manufacturer Name"
#define BLESIG_GATT_DEVICE_INFORMATION_CERTIFICATION_DATA       @"Certification Data"
#define BLESIG_GATT_DEVICE_INFORMATION_PNP_ID                   @"PnP ID"

#define BLESIG_GATT_BATTERY_LEVEL                               @"Battery Level"

#define BLESIG_GATT_CURRENT_TIME                                @"Current Time"

#define BLESIG_GATT_TX_POWER_LEVEL                              @"Tx Power level"

@interface BLESIGGATTProfiles : NSObject

+ (void)create;

@end
