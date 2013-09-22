//
//  BlueCapPeripheral.h
//  BlueCap
//
//  Created by Troy Stribling on 8/24/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCommon.h"

@class BlueCapService;
@class BlueCapPeripheral;

typedef void(^BlueCapPeripheralCallback)(BlueCapPeripheral* __peripheral);
typedef void(^BlueCapPeripheralRSSICallback)(NSNumber* __rssi, NSError* __error);
typedef void(^BlueCapServicesDiscoveredCallback)(NSArray* _services);

@interface BlueCapPeripheral : NSObject <CBPeripheralDelegate>

@property(nonatomic, readonly)  NSArray* services;
@property(nonatomic, readonly)  NSString* name;
@property(nonatomic, readonly)  NSUUID* identifier;
@property(nonatomic, readonly)  CBPeripheralState state;
@property(nonatomic, readonly)  NSNumber* RSSI;

- (void)discoverAllServices:(BlueCapServicesDiscoveredCallback)__onServicesDiscovered;
- (void)discoverServices:(NSArray*)__services onDiscovery:(BlueCapServicesDiscoveredCallback)__onServicesDiscovered;
- (void)connect:(BlueCapPeripheralCallback)__onPeripheralConnect;
- (void)disconnect:(BlueCapPeripheralCallback)__onPeripheralDisconnect;
- (void)connect;
- (void)disconnect;

@end
