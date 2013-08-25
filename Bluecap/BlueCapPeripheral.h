//
//  BlueCapPeripheral.h
//  BlueCap
//
//  Created by Troy Stribling on 8/24/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//


@class BlueCapService;
@class BlueCapPeripheral;

@protocol BlueCapPeripheralDelegate <NSObject>

@optional

- (void)peripheral:(BlueCapPeripheral*)peripheral didDiscoverServices:(NSError*)error;
- (void)peripheral:(BlueCapPeripheral*)peripheral didDiscoverIncludedServicesForService:(BlueCapService*)service error:(NSError*)error;

@end

@interface BlueCapPeripheral : NSObject <CBPeripheralDelegate>

@property(nonatomic, weak) id<BlueCapPeripheralDelegate> delegate;
@property(nonatomic, readonly, retain) NSArray* services;
@property(nonatomic, readonly) NSString* name;
@property(nonatomic, readonly) NSUUID* identifier;
@property(nonatomic, readonly) CBPeripheralState state;
@property(nonatomic, readonly) NSNumber* RSSI;

+ (BlueCapPeripheral*)withCBPeripheral:(CBPeripheral*)__cbPeripheral;

- (void)discoverAllServices;
- (void)discoverServices:(NSArray*)__services;
- (void)connect;
- (void)disconnect;

@end
