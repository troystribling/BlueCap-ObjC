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

@class BlueCapMutableService;
@class BlueCapMutableCharacteristic;

@class BlueCapPeripheralManager;

#pragma mark - BlueCapCentralManager
typedef void(^BlueCapCentralManagerCallback)(void);
typedef void(^BlueCapPeripheralDiscoveredCallback)(BlueCapPeripheral* __peripheral, NSNumber* __RSSI);
typedef void(^BlueCapPeripheralCallback)(BlueCapPeripheral* __peripheral);

#pragma mark - BlueCapPeripheral
typedef void(^BlueCapPeripheralRSSICallback)(BlueCapPeripheral* __peripheral, NSError* __error);
typedef void(^BlueCapServicesDiscoveredCallback)(NSArray* _services);
typedef void(^BlueCapCharacteristicsDiscoveredCallback)(NSArray* __characteristics);
typedef void(^BlueCapDescriptorsDicoveredCallback)(NSArray* __descriptors);
typedef void(^BlueCapPeripheralConnectCallback)(BlueCapPeripheral* __peripheral, NSError* __error);
typedef void(^BlueCapPeripheralDisconnectCallback)(BlueCapPeripheral* __peripheral);

#pragma mark - Profile
typedef void(^BlueCapServiceProfileBlock)(BlueCapServiceProfile* __serviceProfile);
typedef void(^BlueCapCharacteristicProfileBlock)(BlueCapCharacteristicProfile* __characteristicProfile);

typedef void(^BlueCapCharacteristicProfileAfterDiscoveredCallback)(BlueCapCharacteristic* __characteristic);
typedef NSData*(^BlueCapCharacteristicProfileSerializeNamedObjectCallback)(NSString* __objectName, id __data);
typedef NSData*(^BlueCapCharacteristicProfileSerializeObjectCallback)(id __data);
typedef NSData*(^BlueCapCharacteristicProfileSerializeStringCallback)(NSString* __stringValue);

typedef NSDictionary*(^BlueCapCharacteristicProfileDeserializeDataCallback)(NSData* __data);
typedef NSDictionary*(^BlueCapCharacteristicProfileStringValueCallback)(NSDictionary* __data);

#pragma mark - BlueCapCharacteristic
typedef void(^BlueCapCharacteristicNotificationStateDidChange)(void);
typedef void(^BlueCapCharacteristicDataCallback)(BlueCapCharacteristic* __characteristic, NSError* __error);

#pragma mark - BlueCapDescriptor
typedef void(^BlueCapDescriptorDataCallback)(BlueCapDescriptor* __descriptors, NSError* __error);

#pragma mark - BlueCapPeripheralManager
typedef void(^BlueCapPeripheralManagerCallback)(void);
typedef void(^BlueCapPeripheralManagerAfterServiceAdded)(BlueCapMutableService* __service, NSError* error);

#pragma mark  - BlueCapMutableCharacteristic
typedef void(^BlueCapMutableCharacteristicCallback)(BlueCapMutableCharacteristic* __characteristic);

#endif
