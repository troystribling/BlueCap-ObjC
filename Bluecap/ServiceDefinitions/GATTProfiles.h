//
//  GATTProfiles.h
//  BlueCap
//
//  Created by Troy Stribling on 10/4/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Device Information

#define GATT_DEVICE_INFORMATION_SYSTEM_ID               @"System ID"
#define GATT_DEVICE_INFORMATION_MODEL_NUMBER            @"Model Number"
#define GATT_DEVICE_INFORMATION_SERIAL_NUMBER           @"Serial Number"
#define GATT_DEVICE_INFORMATION_FIRMWARE_REVISION       @"Firmware Revision"
#define GATT_DEVICE_INFORMATION_HARDWARE_REVISION       @"Hardware Revision"
#define GATT_DEVICE_INFORMATION_SOFTWARE_REVISION       @"Software Revision"
#define GATT_DEVICE_INFORMATION_MANUFACTURER_NAME       @"Manufacturer Name"
#define GATT_DEVICE_INFORMATION_CERTIFICATION_DATA      @"Certification Data"
#define GATT_DEVICE_INFORMATION_PNP_ID                  @"PnP ID"

@interface GATTProfiles : NSObject

+ (void)create;

@end
