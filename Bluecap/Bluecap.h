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

#import "BlueCapPeripheralManager.h"
#import "BlueCapProfileManager.h"
#import "BlueCapMutableService.h"
#import "BlueCapMutableCharacteristic.h"
#import "BlueCapMutableDescriptor.h"

#import "BlueCapServiceProfile.h"
#import "BlueCapCharacteristicProfile.h"

#import "TISensorTagServiceProfile.h"
#import "BLESIGGATTProfiles.h"

NSNumber* blueCapUnsignedInt16LittleFromData(NSData* data, NSRange range);
NSNumber* blueCapUnsignedInt16BigFromData(NSData* data, NSRange range);
NSData* blueCapLittleFromUnsignedInt16Array(uint16_t* hostVals, int length);
NSData* blueCapBigFromUnsignedInt16Array(uint16_t* hostVals, int length);

NSNumber* blueCapInt16LittleFromData(NSData* data, NSRange range);
NSNumber* blueCapInt16BigFromData(NSData* data, NSRange range);

NSNumber* blueCapCharFromData(NSData* data, NSRange range);
NSNumber* blueCapUnsignedCharFromData(NSData* data);
NSData* blueCapUnsignedCharToData(uint8_t data);
