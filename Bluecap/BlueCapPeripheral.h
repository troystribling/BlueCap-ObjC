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

@interface BlueCapPeripheral : NSObject <CBPeripheralDelegate>

@property(nonatomic, readonly)  NSArray* services;
@property(nonatomic, readonly)  NSString* name;
@property(nonatomic, readonly)  NSUUID* identifier;
@property(nonatomic, readonly)  CBPeripheralState state;
@property(nonatomic, readonly)  NSNumber* RSSI;
   
- (void)discoverAllServices:(BlueCapServicesDiscoveredCallback)__afterServicesDiscovered;
- (void)discoverServices:(NSArray*)__services onDiscovery:(BlueCapServicesDiscoveredCallback)__afterServicesDiscovered;

- (void)connect:(BlueCapPeripheralCallback)__afterPeripheralConnect;
- (void)disconnect:(BlueCapPeripheralCallback)__afterPeripheralDisconnect;
- (void)connect;
- (void)disconnect;

@end
