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

@property(nonatomic, retain) CBCharacteristic*                  cbCharacteristic;
@property(nonatomic, retain) NSMutableArray*                    discoveredDiscriptors;
@property(nonatomic, retain) BlueCapService*                    service;
@property(nonatomic, copy) BlueCapCharacteristicCallback        onReadCallback;
@property(nonatomic, copy) BlueCapCharacteristicCallback        onWriteCallback;

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

- (BlueCapService*)service {
    return _service;
}

- (CBUUID*)UUID {
    return self.cbCharacteristic.UUID;
}

- (void)startNotifications:(BlueCapCharacteristicCallback)__onReadCallback {
    self.onReadCallback = __onReadCallback;
    [self.service.peripheral.cbPeripheral setNotifyValue:YES forCharacteristic:self.cbCharacteristic];
}

- (void)stopNotifications {
    [self.service.peripheral.cbPeripheral setNotifyValue:NO forCharacteristic:self.cbCharacteristic];
}

- (void)read:(BlueCapCharacteristicCallback)__onReadCallback {
    self.onReadCallback = __onReadCallback;
    [self.service.peripheral.cbPeripheral readValueForCharacteristic:self.cbCharacteristic];
}

- (void)write:(NSData*)data onWrite:(BlueCapCharacteristicCallback)__onWriteCallback {
    self.onWriteCallback = __onWriteCallback;
    [self.service.peripheral.cbPeripheral writeValue:data forCharacteristic:self.cbCharacteristic type:CBCharacteristicWriteWithResponse];
}

- (BOOL)propertyEnabled:(CBCharacteristicProperties)__property {
    return self.properties & __property;
}

#pragma mark -
#pragma mark BlueCapCharacteristic PrivateAPI

@end
