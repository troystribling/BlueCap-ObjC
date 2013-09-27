//
//  BlueCapBlocks.h
//  BlueCap
//
//  Created by Troy Stribling on 9/25/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#ifndef BlueCap_BlueCapBlocks_h
#define BlueCap_BlueCapBlocks_h

@class BlueCapPeripheral;
@class BlueCapCharacteristic;

@class BlueCapCharacteristicData;
@class BlueCapDescriptorData;

@class BlueCapCharacteristicDefinition;
@class BlueCapPeripheralDefinition;
@class BlueCapServiceDefinition;

typedef void(^BlueCapCentralManagerCallback)(void);
typedef void(^BlueCapPeripheralCallback)(BlueCapPeripheral* __peripheral);

typedef void(^BlueCapCharacteristicDataCallback)(BlueCapCharacteristicData* __data, NSError* __error);
typedef void(^BlueCapDescriptorDataCallback)(BlueCapDescriptorData* __data, NSError* __error);

typedef void(^BlueCapPeripheralRSSICallback)(NSNumber* __rssi, NSError* __error);
typedef void(^BlueCapServicesDiscoveredCallback)(NSArray* _services);
typedef void(^BlueCapCharacteristicsDiscoveredCallback)(NSArray* __characteristics);
typedef void(^BlueCapDescriptorsDicoveredCallback)(NSArray* __descriptors);

typedef void(^BlueCapPeripheralDefinitionBlock)(BlueCapPeripheralDefinition* __peripheralDefinition);
typedef void(^BlueCapServiceDefinitionBlock)(BlueCapServiceDefinition* __serviceDefinition);
typedef void(^BlueCapCharacteristicDefinitionBlock)(BlueCapCharacteristicDefinition* __characteristicDefinition);

#endif
