//
//  BlueCapCharacteristic.h
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@class BlueCapService;
@class BlueCapCharacteristicProfile;

@interface BlueCapCharacteristic : NSObject

@property(nonatomic, readonly) NSArray*                     descriptors;
@property(nonatomic, readonly) BOOL                         isBroadcasted;
@property(nonatomic, readonly) BOOL                         isNotifying;
@property(nonatomic, readonly) CBCharacteristicProperties   properties;
@property(nonatomic, readonly) NSData*                      value;
@property(nonatomic, readonly) CBUUID*                      UUID;

- (BlueCapService*)service;
- (BlueCapCharacteristicProfile*)profile;
- (BOOL)hasProfile;

- (BOOL)propertyEnabled:(CBCharacteristicProperties)__property;

- (void)startNotifications:(BlueCapCharacteristicDataCallback)__afterReadCallback;
- (void)stopNotifications;

- (void)read:(BlueCapCharacteristicDataCallback)__afterReadCallback;
- (void)write:(NSData*)__data afterWriteCall:(BlueCapCharacteristicDataCallback)__afterWriteCallback;
- (void)writeValueNamed:(NSString*)__data afterWriteCall:(BlueCapCharacteristicDataCallback)__afterWriteCallback;
- (void)writeValue:(id)__data afterWriteCall:(BlueCapCharacteristicDataCallback)__afterWriteCallback;

- (void)discoverAllDescriptors:(BlueCapDescriptorsDicoveredCallback)__onDiscriptorsDicoveredCallback;

@end
