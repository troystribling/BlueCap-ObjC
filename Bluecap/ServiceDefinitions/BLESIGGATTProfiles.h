//
//  BLESIGGATTProfiles.h
//  BlueCap
//
//  Created by Troy Stribling on 10/4/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@interface BLESIGGATTProfiles : NSObject

+ (void)create;

@end