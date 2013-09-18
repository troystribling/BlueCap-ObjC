//
//  BlueCapCommon.h
//  BlueCap
//
//  Created by Troy Stribling on 9/1/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

@class BlueCapPeripheral;
@class BlueCapDescriptorData;
@class BlueCapCharacteristicData;

typedef void(^BlueCapCentralManagerCallback)(void);
typedef void(^BlueCapPeripheralCallback)(BlueCapPeripheral* __peripheral);
typedef void(^BlueCapPeripheralRSSICallback)(NSNumber* __rssi, NSError* __error);
typedef void(^BlueCapDescriptorCallback)(BlueCapDescriptorData* __descriptor, NSError* __error);
typedef void(^BlueCapCharacteristicCallback)(BlueCapCharacteristicData* __descriptor, NSError* __error);
