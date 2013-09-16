//
//  BlueCapCharacteristic.m
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCentralManager+Private.h"
#import "BlueCapPeripheral+Private.h"
#import "BlueCapService+Private.h"
#import "BlueCapCharacteristic.h"

@interface BlueCapCharacteristic () {
}

@property(nonatomic, retain) CBCharacteristic*              cbCharacteristic;
@property(nonatomic, retain) NSMutableArray*                discoveredDiscriptors;
@property(nonatomic, retain) BlueCapService*                service;
@property(nonatomic, copy) BlueCapCharacteristicCallback    onRead;
@property(nonatomic, copy) BlueCapCharacteristicCallback    onWrite;

@end

@implementation BlueCapCharacteristic

#pragma mark -
#pragma mark BlueCapCharacteristic

- (NSArray*)descriptors {
    __block NSArray* __descriptors = [NSArray array];
    [[BlueCapCentralManager sharedInstance] sync:^{
        __descriptors = [NSArray arrayWithArray:self.discoveredDiscriptors];
    }];
    return __descriptors;
}

- (BOOL)isBroadcasted {
    return self.cbCharacteristic.isBroadcasted;
}

-(BOOL)isNotifying {
    __block BOOL __isNotifying = NO;
    [[BlueCapCentralManager sharedInstance] sync:^{
        __isNotifying = self.cbCharacteristic.isNotifying;
    }];
    return __isNotifying;
}

- (CBCharacteristicProperties)properties {
    return self.cbCharacteristic.properties;
}

- (void)discoverDescriptors {
    [_service.peripheral.cbPeripheral discoverDescriptorsForCharacteristic:self.cbCharacteristic];
}

- (BlueCapService*)service {
    return _service;
}

- (CBUUID*)UUID {
    return self.cbCharacteristic.UUID;
}

- (void)startNotifications:(BlueCapCharacteristicCallback)__onRead {
    self.onRead = __onRead;
    [self.service.peripheral.cbPeripheral setNotifyValue:YES forCharacteristic:self.cbCharacteristic];
}

- (void)stopNotifications {
    [self.service.peripheral.cbPeripheral setNotifyValue:NO forCharacteristic:self.cbCharacteristic];
}

- (void)read:(BlueCapCharacteristicCallback)__onRead {
    self.onRead = __onRead;
    [self.service.peripheral.cbPeripheral readValueForCharacteristic:self.cbCharacteristic];
}

- (void)write:(NSData*)data onWrite:(BlueCapCharacteristicCallback)__onWrite {
    self.onWrite = __onWrite;
    [self.service.peripheral.cbPeripheral writeValue:data forCharacteristic:self.cbCharacteristic type:CBCharacteristicWriteWithResponse];
}

- (BOOL)propertyEnabled:(CBCharacteristicProperties)__property {
    return self.properties & __property;
}

#pragma mark -
#pragma mark BlueCapCharacteristic PrivateAPI

@end
