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

@property(nonatomic, readonly) NSArray*                                     descriptors;
@property(nonatomic, readonly) BOOL                                         isBroadcasted;
@property(nonatomic, readonly) BOOL                                         isNotifying;
@property(nonatomic, readonly) CBCharacteristicProperties                   properties;
@property(nonatomic, readonly) CBUUID*                                      UUID;
@property(nonatomic, readonly) NSString*                                    name;

- (BlueCapService*)service;
- (BlueCapCharacteristicProfile*)profile;
- (BOOL)hasProfile;
- (BOOL)hasValues;
- (NSArray*)allValues;

- (NSData*)dataValue;
- (NSDictionary*)value;
- (NSDictionary*)stringValue;

- (BOOL)propertyEnabled:(CBCharacteristicProperties)__property;

- (void)startNotifications:(BlueCapCharacteristicNotificationStateDidChange)__notificationStateDidChangeCallback;
- (void)stopNotifications:(BlueCapCharacteristicNotificationStateDidChange)__notificationStateDidChangeCallback;
- (void)receiveUpdates:(BlueCapCharacteristicDataCallback)__afterReadCallback;
- (void)dropUpdates;

- (void)readData:(BlueCapCharacteristicDataCallback)__afterReadCallback;

- (void)writeData:(NSData*)__data afterWriteCall:(BlueCapCharacteristicDataCallback)__afterWriteCallback;
- (void)writeData:(NSData*)__data;
- (void)writeObject:(id)__data afterWriteCall:(BlueCapCharacteristicDataCallback)__afterWriteCallback;
- (void)writeObject:(id)__data;
- (void)writeValueObject:(NSString*)__data afterWriteCall:(BlueCapCharacteristicDataCallback)__afterWriteCallback;
- (void)writeValueObject:(NSString*)__data;
- (void)writeString:(NSDictionary*)__data afterWriteCall:(BlueCapCharacteristicDataCallback)__afterWriteCallback;
- (void)writeString:(NSDictionary*)__data;

- (void)discoverAllDescriptors:(BlueCapDescriptorsDicoveredCallback)__onDiscriptorsDicoveredCallback;

@end
