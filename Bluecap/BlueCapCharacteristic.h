//
//  BlueCapCharacteristic.h
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCommon.h"

@class BlueCapService;
@class BlueCapCharacteristicData;

typedef void(^BlueCapCharacteristicCallback)(BlueCapCharacteristicData* __descriptor, NSError* __error);

@interface BlueCapCharacteristic : NSObject

@property(nonatomic, readonly) NSArray*                     descriptors;
@property(nonatomic, readonly) BOOL                         isBroadcasted;
@property(nonatomic, readonly) BOOL                         isNotifying;
@property(nonatomic, readonly) CBCharacteristicProperties   properties;
@property(nonatomic, readonly) NSData*                      value;
@property(nonatomic, readonly) CBUUID*                      UUID;

- (void)discoverDescriptors;
- (BlueCapService*)service;

- (void)startNotifications:(BlueCapCharacteristicCallback)__onRead;
- (void)stopNotifications;
- (void)read:(BlueCapCharacteristicCallback)__onReadCallback;
- (void)write:(NSData*)data onWrite:(BlueCapCharacteristicCallback)__onWriteCallback;
- (BOOL)propertyEnabled:(CBCharacteristicProperties)__property;

@end
