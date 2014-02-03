//
//  BlueCapPeripheral.h
//  BlueCap
//
//  Created by Troy Stribling on 8/24/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@class BlueCapService;
@class BlueCapPeripheral;
@class BlueCapPeripheralProfile;

typedef enum {
    BLueCapPeripheralConnectionErrorNone,
    BLueCapPeripheralConnectionErrorTimeout,
    BLueCapPeripheralConnectionErrorDisconnected
} BLueCapPeripheralConnectionError;

@interface BlueCapPeripheral : NSObject <CBPeripheralDelegate>

@property(nonatomic, readonly)  NSArray*                services;
@property(nonatomic, readonly)  NSString*               name;
@property(nonatomic, readonly)  NSUUID*                 identifier;
@property(nonatomic, readonly)  CBPeripheralState       state;
@property(nonatomic, readonly)  NSNumber*               RSSI;

- (NSDictionary*)advertisement;

- (void)discoverAllServices:(BlueCapServicesDiscoveredCallback)__afterServicesDiscovered;
- (void)discoverServices:(NSArray*)__services afterDiscovery:(BlueCapServicesDiscoveredCallback)__afterServicesDiscovered;

- (void)discoverAllServicesAndCharacteristics:(BlueCapPeripheralServiceAndCharacteristicDiscoveryCallback)__afterDiscoveryCallback;
- (void)discoverServices:(NSArray*)__services
      andCharacteristics:(NSArray*)__characteristics
      afterDiscoveryCall:(BlueCapPeripheralServiceAndCharacteristicDiscoveryCallback)__afterDiscoveryCallback;

- (void)recieveRSSIUpdates:(BlueCapPeripheralRSSICallback)__afterRSSIUpdate;
- (void)dropRSSIUpdates;

- (void)connect:(BlueCapPeripheralConnectCallback)__afterPeripheralConnect;
- (void)connect:(BlueCapPeripheralConnectCallback)__afterPeripheralConnect afterPeripheralDisconnect:(BlueCapPeripheralDisconnectCallback)__afterPeripheralDisconnect;
- (void)connectAndReconnectOnDisconnect:(BlueCapPeripheralConnectCallback)__afterPeripheralConnect;
- (void)connect;
- (void)disconnect:(BlueCapPeripheralDisconnectCallback)__afterPeripheralDisconnect;
- (void)disconnect;

@end
