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
@class BlueCapDescriptor;

@class BlueCapCharacteristicProfile;
@class BlueCapPeripheralProfile;
@class BlueCapServiceProfile;

@class BlueCapPeripheralManager;

typedef void(^BlueCapCentralManagerCallback)(void);
typedef void(^BlueCapPeripheralDiscoveredCallback)(BlueCapPeripheral* __peripheral, NSNumber* __RSSI);
typedef void(^BlueCapPeripheralCallback)(BlueCapPeripheral* __peripheral);

typedef void(^BlueCapPeripheralRSSICallback)(BlueCapPeripheral* __peripheral, NSError* __error);
typedef void(^BlueCapServicesDiscoveredCallback)(NSArray* _services);
typedef void(^BlueCapCharacteristicsDiscoveredCallback)(NSArray* __characteristics);
typedef void(^BlueCapDescriptorsDicoveredCallback)(NSArray* __descriptors);
typedef void(^BlueCapPeripheralConnectCallback)(BlueCapPeripheral* __peripheral, NSError* __error);
typedef void(^BlueCapPeripheralDisconnectCallback)(BlueCapPeripheral* __peripheral);

typedef void(^BlueCapPeripheralProfileBlock)(BlueCapPeripheralProfile* __peripheralProfile);
typedef void(^BlueCapServiceProfileBlock)(BlueCapServiceProfile* __serviceProfile);
typedef void(^BlueCapCharacteristicProfileBlock)(BlueCapCharacteristicProfile* __characteristicProfile);

typedef void(^BlueCapCharacteristicNotificationStateDidChange)(void);

typedef void(^BlueCapCharacteristicProfileAfterDiscoveredCallback)(BlueCapCharacteristic* __characteristic);
typedef NSData*(^BlueCapCharacteristicProfileSerializeNamedObjectCallback)(NSString* __objectName, id __data);
typedef NSData*(^BlueCapCharacteristicProfileSerializeObjectCallback)(id __data);

typedef NSDictionary*(^BlueCapCharacteristicProfileDeserializeDataCallback)(NSData* __data);
typedef NSDictionary*(^BlueCapCharacteristicProfileStringValueCallback)(NSDictionary* __data);

typedef void(^BlueCapCharacteristicDataCallback)(BlueCapCharacteristic* __characteristic, NSError* __error);
typedef void(^BlueCapDescriptorDataCallback)(BlueCapDescriptor* __descriptors, NSError* __error);

typedef void(^BlueCapPeripheralManagerStartedAdvertising)(BlueCapPeripheralManager* __peripheralManager);
typedef void(^BlueCapPeripheralManagerStoppedAdvertising)(BlueCapPeripheralManager* __peripheralManager);

#endif
