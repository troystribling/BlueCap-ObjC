//
//  Bluecap.h
//  Bluecap
//
//  Created by Troy Stribling on 8/11/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "DebugLog.h"
#import "CBUUID+StringValue.h"

#import "BlueCapCentralManager.h"
#import "BlueCapPeripheral.h"
#import "BlueCapService.h"
#import "BlueCapCharacteristic.h"
#import "BlueCapDescriptor.h"

#import "BlueCapCharacteristicData.h"
#import "BlueCapDescriptorData.h"

#import "BlueCapServiceProfile.h"
#import "BlueCapCharacteristicProfile.h"

#import "TISensorTagServiceProfile.h"
#import "GATTProfiles.h"

NSNumber* blueCapCharFromData(NSData* data, NSRange range);
NSNumber* blueCapUnsignedCharFromData(NSData* data);
NSData* blueCapUnsignedCharToData(uint8_t data);
