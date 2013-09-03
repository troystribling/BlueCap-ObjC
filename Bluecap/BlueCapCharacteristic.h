//
//  BlueCapCharacteristic.h
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCommon.h"

@class BlueCapService;

@interface BlueCapCharacteristic : NSObject

@property(nonatomic, readonly) NSArray*             descriptors;
@property(nonatomic, readonly) BOOL                 isBroadcasted;
@property(nonatomic, readonly) BOOL                 isNotifying;
@property(nonatomic, readonly) NSArray*             properties;
@property(nonatomic, readonly) NSData*              value;
@property(nonatomic, readonly) CBUUID*              UUID;

- (void)discoverDescriptors;
- (BlueCapService*)service;

- (void)startNotifications:(BlueCapCallback)__onRead;
- (void)stopNotifications;
- (void)read:(BlueCapCallback)__onRead;
- (void)write:(NSData*)data onWrite:(BlueCapCallback)__onWrite;

@end
