//
//  BlueCapCharacteristic.h
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@class BlueCapService;

@interface BlueCapCharacteristic : NSObject

@property(nonatomic, readonly) NSArray*                     descriptors;
@property(nonatomic, readonly) BOOL                         isBroadcasted;
@property(nonatomic, readonly) BOOL                         isNotifying;
@property(nonatomic, readonly) CBCharacteristicProperties   properties;
@property(nonatomic, readonly) NSData*                      value;
@property(nonatomic, readonly) CBUUID*                      UUID;

- (BlueCapService*)service;
- (BOOL)propertyEnabled:(CBCharacteristicProperties)__property;

- (void)startNotifications:(BlueCapCharacteristicDataCallback)__onReadCallback;
- (void)stopNotifications;

- (void)read:(BlueCapCharacteristicDataCallback)__onReadCallback;
- (void)write:(NSData*)data onWrite:(BlueCapCharacteristicDataCallback)__onWriteCallback;

- (void)discoverAllDescriptors:(BlueCapDescriptorsDicoveredCallback)__onDiscriptorsDicoveredCallback;

@end
