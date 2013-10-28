//
//  BLEGATTProfiles.h
//  BlueCap
//
//  Created by Troy Stribling on 10/4/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Device Information

#define BLE_GATT_DEVICE_INFORMATION_SYSTEM_ID               @"System ID"
#define BLE_GATT_DEVICE_INFORMATION_MODEL_NUMBER            @"Model Number"
#define BLE_GATT_DEVICE_INFORMATION_SERIAL_NUMBER           @"Serial Number"
#define BLE_GATT_DEVICE_INFORMATION_FIRMWARE_REVISION       @"Firmware Revision"
#define BLE_GATT_DEVICE_INFORMATION_HARDWARE_REVISION       @"Hardware Revision"
#define BLE_GATT_DEVICE_INFORMATION_SOFTWARE_REVISION       @"Software Revision"
#define BLE_GATT_DEVICE_INFORMATION_MANUFACTURER_NAME       @"Manufacturer Name"
#define BLE_GATT_DEVICE_INFORMATION_CERTIFICATION_DATA      @"Certification Data"
#define BLE_GATT_DEVICE_INFORMATION_PNP_ID                  @"PnP ID"

@interface BLEGATTProfiles : NSObject

+ (void)create;

@end
