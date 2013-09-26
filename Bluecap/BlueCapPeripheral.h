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

- (BlueCapServiceDefinition*)createServiceWithUUID:(NSString*)__uuidString;
- (BlueCapServiceDefinition*)createServiceWithUUID:(NSString*)__uuidString andDefinition:(BlueCapServiceDefinitionBlock)__definitionBlock;


@end
