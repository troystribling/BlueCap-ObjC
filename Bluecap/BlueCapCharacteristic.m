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
#import "BlueCapCharacteristic+Friend.h"
#import "CBUUID+StringValue.h"
#import "NSData+HexStringValue.h"

#define CHARACTERISTIC_UPDATE_TIMEOUT   20.0

@interface BlueCapCharacteristic () {
}

@property(nonatomic, retain) CBCharacteristic*                    cbCharacteristic;
@property(nonatomic, retain) NSMutableArray*                      discoveredDiscriptors;
@property(nonatomic, retain) BlueCapService*                      service;
@property(nonatomic, retain) BlueCapCharacteristicProfile*        profile;
@property(nonatomic, assign) NSInteger                            timeoutSequenceNumber;
@property(nonatomic, assign) BOOL                                 updateReceived;
@property(nonatomic, assign) BOOL                                 writeReceived;

@property(nonatomic, copy) BlueCapCharacteristicDataCallback                afterReadCallback;
@property(nonatomic, copy) BlueCapCharacteristicDataCallback                afterWriteCallback;
@property(nonatomic, copy) BlueCapDescriptorsDicoveredCallback              afterDescriptorsDiscoveredCallback;
@property(nonatomic, copy) BlueCapCharacteristicNotificationStateDidChange  notificationStateDidChangeCallback;


- (void)timeout:(NSInteger)__sequenceNumber check:(BOOL)__readOrWrite;
- (NSError*)error;

@end

@implementation BlueCapCharacteristic

#pragma mark - BlueCapCharacteristic

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

- (NSString*)name {
    if ([self hasProfile]) {
        return self.profile.name;
    } else {
        return @"Unkown";
    }
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

- (BOOL)hasValues {
    BOOL result = NO;
    if ([self hasProfile]) {
        result = [self.profile hasValues];
    }
    return result;
}

- (NSData*)dataValue {
    __block NSData* __value = [NSData data];
    [[BlueCapCentralManager sharedInstance] syncMain:^{
        __value = self.cbCharacteristic.value;
    }];
    return __value;
}

- (NSDictionary*)value {
    return [BlueCapCharacteristicProfile deserializeData:[self dataValue] usingProfile:self.profile];
}

- (NSDictionary*)stringValue {
    if ([self hasProfile]) {
        return [BlueCapCharacteristicProfile stringValue:[self value] usingProfile:self.profile];
    } else {
        return @{@"Hexidecimal":[[self dataValue] hexStringValue],
                 @"UTF-8":[[NSString alloc] initWithData:[self dataValue] encoding:NSUTF8StringEncoding],
                 @"Length":[NSString stringWithFormat:@"%lu", (unsigned long)[[self dataValue] length]]};
    }
}

- (NSArray*)allValues {
    NSArray* valueNames = [NSArray array];
    if ([self hasValues]) {
        valueNames = [self.profile allValues];
    }
    return valueNames;
}

#pragma mark - Manage Notifications

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

#pragma mark - I/O

- (void)readData:(BlueCapCharacteristicDataCallback)__afterReadCallback {
    if ([self propertyEnabled:CBCharacteristicPropertyRead]) {
        self.afterReadCallback = __afterReadCallback;
        [self.service.peripheral.cbPeripheral readValueForCharacteristic:self.cbCharacteristic];
        self.updateReceived = NO;
        self.timeoutSequenceNumber++;
        [self timeout:self.timeoutSequenceNumber check:YES];
    } else {
        [NSException raise:@"Read not supported" format:@"characteristic %@ does not support read", [self.UUID stringValue]];
    }
}

- (void)writeData:(NSData*)__data afterWriteCall:(BlueCapCharacteristicDataCallback)__afterWriteCallback {
    if ([self propertyEnabled:CBCharacteristicPropertyWrite]) {
        self.afterWriteCallback = __afterWriteCallback;
        [self.service.peripheral.cbPeripheral writeValue:__data forCharacteristic:self.cbCharacteristic type:CBCharacteristicWriteWithResponse];
        self.timeoutSequenceNumber++;
        [self timeout:self.timeoutSequenceNumber check:NO];
    } else {
        [NSException raise:@"Write with response not supported" format:@"characteristic %@ does not support write with response", [self.UUID stringValue]];
    }
}

- (void)writeData:(NSData*)__data {
    if ([self propertyEnabled:CBCharacteristicPropertyWriteWithoutResponse]) {
        [self.service.peripheral.cbPeripheral writeValue:__data forCharacteristic:self.cbCharacteristic type:CBCharacteristicWriteWithoutResponse];
        self.writeReceived = NO;
    } else {
        [NSException raise:@"Write without response not supported" format:@"characteristic %@ does not support write without response", [self.UUID stringValue]];
    }
}

- (void)writeValueObject:(NSString*)__objectName afterWriteCall:(BlueCapCharacteristicDataCallback)__afterWriteCallback {
    NSData* serializedValue = [BlueCapCharacteristicProfile serializeNamedObject:__objectName usingProfile:self.profile];
    [self writeData:serializedValue afterWriteCall:__afterWriteCallback];
}

- (void)writeValueObject:(NSString*)__objectName {
    NSData* serializedValue = [BlueCapCharacteristicProfile serializeNamedObject:__objectName usingProfile:self.profile];
    [self writeData:serializedValue];
}
- (void)writeObject:(id)__object afterWriteCall:(BlueCapCharacteristicDataCallback)__afterWriteCallback {
    NSData* serializedValue = [BlueCapCharacteristicProfile serializeObject:__object usingProfile:self.profile];
    [self writeData:serializedValue afterWriteCall:__afterWriteCallback];
}

- (void)writeObject:(id)__object {
    NSData* serializedValue = [BlueCapCharacteristicProfile serializeObject:__object usingProfile:self.profile];
    [self writeData:serializedValue];
}

- (void)writeString:(NSDictionary*)__value afterWriteCall:(BlueCapCharacteristicDataCallback)__afterWriteCallback {
    NSData* serializedValue = [BlueCapCharacteristicProfile serializeString:__value usingProfile:self.profile];
    [self writeData:serializedValue afterWriteCall:__afterWriteCallback];
}

- (void)writeString:(NSDictionary*)__value {
    NSData* serializedValue = [BlueCapCharacteristicProfile serializeString:__value usingProfile:self.profile];
    [self writeData:serializedValue];
}

#pragma mark - Discover Descriptors

- (void)discoverAllDescriptors:(BlueCapDescriptorsDicoveredCallback)__afterDescriptorsDiscoveredCallback {
    self.afterDescriptorsDiscoveredCallback = __afterDescriptorsDiscoveredCallback;
    [self.service.peripheral.cbPeripheral discoverDescriptorsForCharacteristic:self.cbCharacteristic];
}

#pragma mark - BlueCapCharacteristic Private

- (void)timeout:(NSInteger)__sequenceNumber check:(BOOL)__readOrWrite {
    [[BlueCapCentralManager sharedInstance] delayCallback:CHARACTERISTIC_UPDATE_TIMEOUT withBlock:^{
        DLog(@"Sequence Number:%d, this sequence number: %d", self.timeoutSequenceNumber, __sequenceNumber);
        if (__readOrWrite) {
            if (self.timeoutSequenceNumber == __sequenceNumber && !self.updateReceived) {
                DLog(@"Read timeout");
                [[BlueCapCentralManager sharedInstance].centralManager cancelPeripheralConnection:self.service.peripheral.cbPeripheral];
                [self didUpdateValue:[self error]];
            }
        } else {
            if (self.timeoutSequenceNumber == __sequenceNumber && !self.writeReceived) {
                DLog(@"Write timeout");
                [[BlueCapCentralManager sharedInstance].centralManager cancelPeripheralConnection:self.service.peripheral.cbPeripheral];
                [self didWriteValue:[self error]];
            }
        }
    }];
}

- (NSError*)error {
    return [NSError errorWithDomain:@"BlueCap"
                               code:408
                           userInfo:@{NSLocalizedDescriptionKey: @"Update Timeout"}];
}

@end
