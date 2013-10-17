//
//  BlueCapCharacteristic.m
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCentralManager+Friend.h"
#import "BlueCapPeripheral+Friend.h"
#import "BlueCapService+Friend.h"
#import "BlueCapCharacteristicProfile+Friend.h"
#import "BlueCapCharacteristic.h"
#import "CBUUID+StringValue.h"

@interface BlueCapCharacteristic () {
}

@property(nonatomic, retain) CBCharacteristic*                  cbCharacteristic;
@property(nonatomic, retain) NSMutableArray*                    discoveredDiscriptors;
@property(nonatomic, retain) BlueCapService*                    service;
@property(nonatomic, retain) BlueCapCharacteristicProfile*      profile;

@property(nonatomic, copy) BlueCapCharacteristicDataCallback                afterReadCallback;
@property(nonatomic, copy) BlueCapCharacteristicDataCallback                afterWriteCallback;
@property(nonatomic, copy) BlueCapDescriptorsDicoveredCallback              afterDescriptorsDiscoveredCallback;
@property(nonatomic, copy) BlueCapCharacteristicNotificationStateDidChange  notificationStateDidChangeCallback;

@end

@implementation BlueCapCharacteristic

#pragma mark -
#pragma mark BlueCapCharacteristic

- (NSArray*)descriptors {
    __block NSArray* __descriptors = [NSArray array];
    [[BlueCapCentralManager sharedInstance] syncMain:^{
        __descriptors = [NSArray arrayWithArray:self.discoveredDiscriptors];
    }];
    return __descriptors;
}

- (BOOL)isBroadcasted {
    return self.cbCharacteristic.isBroadcasted;
}

-(BOOL)isNotifying {
    __block BOOL __isNotifying = NO;
    [[BlueCapCentralManager sharedInstance] syncMain:^{
        __isNotifying = self.cbCharacteristic.isNotifying;
    }];
    return __isNotifying;
}

- (CBCharacteristicProperties)properties {
    return self.cbCharacteristic.properties;
}

- (CBUUID*)UUID {
    return self.cbCharacteristic.UUID;
}

- (BlueCapService*)service {
    return _service;
}

- (BlueCapCharacteristicProfile*)profile {
    return _profile;
}

- (BOOL)propertyEnabled:(CBCharacteristicProperties)__property {
    return self.properties & __property;
}

- (BOOL)hasProfile {
    return self.profile != nil;
}

#pragma mark -
#pragma mark Manage Notifications

- (void)startNotifications:(BlueCapCharacteristicNotificationStateDidChange)__notificationStateDidChangeCallback {
    if ([self propertyEnabled:CBCharacteristicPropertyNotify]) {
        self.notificationStateDidChangeCallback = __notificationStateDidChangeCallback;
        [self.service.peripheral.cbPeripheral setNotifyValue:YES forCharacteristic:self.cbCharacteristic];
    } else {
        [NSException raise:@"Notifications not supported" format:@"characteristic %@ does not support notifications", [self.UUID stringValue]];
    }
}

- (void)stopNotifications:(BlueCapCharacteristicNotificationStateDidChange)__notificationStateDidChangeCallback {
    if ([self propertyEnabled:CBCharacteristicPropertyNotify]) {
        self.notificationStateDidChangeCallback = __notificationStateDidChangeCallback;
        [self.service.peripheral.cbPeripheral setNotifyValue:NO forCharacteristic:self.cbCharacteristic];
    } else {
        [NSException raise:@"Notifications not supported" format:@"characteristic %@ does not support notifications", [self.UUID stringValue]];
    }
}

- (void)receiveUpdates:(BlueCapCharacteristicDataCallback)__afterReadCallback {
    if ([self propertyEnabled:CBCharacteristicPropertyNotify]) {
        self.afterReadCallback = __afterReadCallback;
    } else {
        [NSException raise:@"Notifications not supported" format:@"characteristic %@ does not support notifications", [self.UUID stringValue]];
    }
}

- (void)dropUpdates {
    if ([self propertyEnabled:CBCharacteristicPropertyNotify]) {
        self.afterReadCallback = nil;
    } else {
        [NSException raise:@"Notifications not supported" format:@"characteristic %@ does not support notifications", [self.UUID stringValue]];
    }
}

#pragma mark -
#pragma I/O

- (void)readData:(BlueCapCharacteristicDataCallback)__afterReadCallback {
    if ([self propertyEnabled:CBCharacteristicPropertyRead]) {
        self.afterReadCallback = __afterReadCallback;
        [self.service.peripheral.cbPeripheral readValueForCharacteristic:self.cbCharacteristic];
    } else {
        [NSException raise:@"Read not supported" format:@"characteristic %@ does not support read", [self.UUID stringValue]];
    }
}

- (void)writeData:(NSData*)__data afterWriteCall:(BlueCapCharacteristicDataCallback)__afterWriteCallback {
    if ([self propertyEnabled:CBCharacteristicPropertyWrite]) {
        self.afterWriteCallback = __afterWriteCallback;
        [self.service.peripheral.cbPeripheral writeValue:__data forCharacteristic:self.cbCharacteristic type:CBCharacteristicWriteWithResponse];
    } else {
        [NSException raise:@"Write with response not supported" format:@"characteristic %@ does not support write with response", [self.UUID stringValue]];
    }
}

- (void)writeData:(NSData*)__data {
    if ([self propertyEnabled:CBCharacteristicPropertyWriteWithoutResponse]) {
        [self.service.peripheral.cbPeripheral writeValue:__data forCharacteristic:self.cbCharacteristic type:CBCharacteristicWriteWithoutResponse];
    } else {
        [NSException raise:@"Write without response not supported" format:@"characteristic %@ does not support write without response", [self.UUID stringValue]];
    }
}

- (void)writeValueNamed:(NSString*)__valueName afterWriteCall:(BlueCapCharacteristicDataCallback)__afterWriteCallback {
    if (self.profile) {
        BlueCapCharacteristicProfileSerializeValueCallback serializeBlock = [self.profile.serializeBlocks objectForKey:__valueName];
        if (serializeBlock) {
            [self writeData:serializeBlock() afterWriteCall:__afterWriteCallback];
        }
    }
}

- (void)writeValueNamed:(NSString*)__valueName {
    if (self.profile) {
        BlueCapCharacteristicProfileSerializeValueCallback serializeBlock = [self.profile.serializeBlocks objectForKey:__valueName];
        if (serializeBlock) {
            [self writeData:serializeBlock()];
        }
    }
}
- (void)writeObject:(id)__data afterWriteCall:(BlueCapCharacteristicDataCallback)__afterWriteCallback {
    if (self.profile) {
        BlueCapCharacteristicProfileSerializeObjectCallback serilizeBlock = self.profile.serializeObjectCallback;
        if (serilizeBlock) {
            [self writeData:serilizeBlock(__data) afterWriteCall:__afterWriteCallback];
        }
    }
}

- (void)writeObject:(id)__data {
    if (self.profile) {
        BlueCapCharacteristicProfileSerializeObjectCallback serilizeBlock = self.profile.serializeObjectCallback;
        if (serilizeBlock) {
            [self writeData:serilizeBlock(__data)];
        }
    }
}

#pragma mark -
#pragma mark Discover Descriptors

- (void)discoverAllDescriptors:(BlueCapDescriptorsDicoveredCallback)__afterDescriptorsDiscoveredCallback {
    self.afterDescriptorsDiscoveredCallback = __afterDescriptorsDiscoveredCallback;
    [self.service.peripheral.cbPeripheral discoverDescriptorsForCharacteristic:self.cbCharacteristic];
}

#pragma mark -
#pragma mark BlueCapCharacteristic PrivateAPI

@end
