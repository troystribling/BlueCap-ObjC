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

@interface BlueCapCharacteristic () {
}

@property(nonatomic, retain) CBCharacteristic*                  cbCharacteristic;
@property(nonatomic, retain) NSMutableArray*                    discoveredDiscriptors;
@property(nonatomic, retain) BlueCapService*                    service;
@property(nonatomic, retain) BlueCapCharacteristicProfile*      profile;

@property(nonatomic, copy) BlueCapCharacteristicDataCallback    afterReadCallback;
@property(nonatomic, copy) BlueCapCharacteristicDataCallback    afterWriteCallback;
@property(nonatomic, copy) BlueCapDescriptorsDicoveredCallback  onDescriptorsDiscoveredCallback;

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

- (void)startNotifications:(BlueCapCharacteristicDataCallback)__afterReadCallback {
    self.afterReadCallback = __afterReadCallback;
    [self.service.peripheral.cbPeripheral setNotifyValue:YES forCharacteristic:self.cbCharacteristic];
}

- (void)stopNotifications {
    [self.service.peripheral.cbPeripheral setNotifyValue:NO forCharacteristic:self.cbCharacteristic];
}

#pragma mark - 
#pragma I/O

- (void)read:(BlueCapCharacteristicDataCallback)__afterReadCallback {
    self.afterReadCallback = __afterReadCallback;
    [self.service.peripheral.cbPeripheral readValueForCharacteristic:self.cbCharacteristic];
}

- (void)write:(NSData*)__data afterWriteCall:(BlueCapCharacteristicDataCallback)__afterWriteCallback {
    self.afterWriteCallback = __afterWriteCallback;
    [self.service.peripheral.cbPeripheral writeValue:__data forCharacteristic:self.cbCharacteristic type:CBCharacteristicWriteWithResponse];
}

- (void)writeValueNamed:(NSString*)__valueName afterWriteCall:(BlueCapCharacteristicDataCallback)__afterWriteCallback {
    if (self.profile) {
        BlueCapCharacteristicProfileSerializeCallback serializeBlock = [self.profile.serializeBlocks objectForKey:__valueName];
        if (serializeBlock) {
            [self write:serializeBlock() afterWriteCall:__afterWriteCallback];
        }
    }
}

- (void)writeValue:(id)__data afterWriteCall:(BlueCapCharacteristicDataCallback)__afterWriteCallback {
    if (self.profile) {
        if (self.profile.serializeCallback) {
            [self write:self.profile.serializeCallback(__data) afterWriteCall:__afterWriteCallback];
        }
    }
}

#pragma mark -
#pragma mark Discover Descriptors

- (void)discoverAllDescriptors:(BlueCapDescriptorsDicoveredCallback)__onDiscriptorsDicoveredCallback {
    self.onDescriptorsDiscoveredCallback = __onDiscriptorsDicoveredCallback;
    [self.service.peripheral.cbPeripheral discoverDescriptorsForCharacteristic:self.cbCharacteristic];
}

#pragma mark -
#pragma mark BlueCapCharacteristic PrivateAPI

@end
