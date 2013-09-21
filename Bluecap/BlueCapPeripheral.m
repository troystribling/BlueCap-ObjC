//
//  BlueCapPeripheral.m
//  BlueCap
//
//  Created by Troy Stribling on 8/24/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCentralManager+Private.h"
#import "BlueCapPeripheral+Private.h"
#import "BlueCapService+Private.h"
#import "BlueCapCharacteristic+Private.h"
#import "BlueCapDescriptor+Private.h"
#import "CBUUID+StringValue.h"

@interface BlueCapPeripheral ()

@property(nonatomic, retain) CBPeripheral*                  cbPeripheral;
@property(nonatomic, retain) NSMutableArray*                discoveredServices;
@property(nonatomic, retain) NSMapTable*                    discoveredObjects;

@property(nonatomic, copy) BlueCapPeripheralCallback        onPeriperialDisconnect;
@property(nonatomic, copy) BlueCapPeripheralCallback        onPeripheralConnect;
@property(nonatomic, copy) BlueCapPeripheralRSSICallback    onRSSIUpdate;

@end

@implementation BlueCapPeripheral

#pragma mark -
#pragma mark BlueCapPeripheral

- (NSArray*)services {
    __block NSArray* __services = [NSArray array];
    [[BlueCapCentralManager sharedInstance] syncMain:^{
        __services = [NSArray arrayWithArray:self.discoveredServices];
    }];
    return __services;
}

- (NSString*)name {
    return self.cbPeripheral.name;
}

- (NSUUID*)identifier {
    return self.cbPeripheral.identifier;
}

- (CBPeripheralState)state {
    __block CBPeripheralState __state = CBPeripheralStateDisconnected;
    [[BlueCapCentralManager sharedInstance] syncMain:^{
        __state = self.cbPeripheral.state;
    }];
    return __state;
}

- (NSNumber*)RSSI {
    [self.cbPeripheral readRSSI];
    return self.cbPeripheral.RSSI;
}

- (void)discoverAllServices {
    [self.cbPeripheral discoverServices:nil];
}

- (void)discoverServices:(NSArray*)__services {
    [self.cbPeripheral discoverServices:__services];
}

- (void)connect:(BlueCapPeripheralCallback)__onPeripheralConnect {
    if (self.cbPeripheral.state == CBPeripheralStateDisconnected) {
        self.onPeripheralConnect = __onPeripheralConnect;
        [[BlueCapCentralManager sharedInstance].centralManager connectPeripheral:self.cbPeripheral options:nil];
    }
}

- (void)disconnect:(BlueCapPeripheralCallback)__onPeripheralDisconnect {
    if (self.cbPeripheral.state == CBPeripheralStateConnected) {
        self.onPeriperialDisconnect = __onPeripheralDisconnect;
        [[BlueCapCentralManager sharedInstance].centralManager cancelPeripheralConnection:self.cbPeripheral];
    }
}

- (void)connect {
    [self connect:nil];
}

- (void)disconnect {
    [self disconnect:nil];
}

#pragma mark -
#pragma mark BlueCapPeripheral PrivateAPI

#pragma mark -
#pragma mark CBPeripheralDelegate

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverServices:(NSError*)error {
    DLog(@"Discovered %d Services", [peripheral.services count]);
    for (CBService* service in peripheral.services) {
        BlueCapService* bcService = [BlueCapService withCBService:service andPeripheral:self];
        [self.discoveredObjects setObject:bcService forKey:service];
        [self.discoveredServices addObject:bcService];
    }
    if ([self.delegate respondsToSelector:@selector(peripheral:didDiscoverServices:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate peripheral:self didDiscoverServices:error];
        });
        
    }
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverIncludedServicesForService:(CBService*)service error:(NSError*)error {
    DLog(@"Discovered %d Included Services", [service.includedServices count]);
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverCharacteristicsForService:(CBService*)service error:(NSError*)error {
    DLog(@"Discovered %d Service Characteristics", [service.characteristics count]);
    BlueCapService* bcService = [self.discoveredObjects objectForKey:service];
    for (CBCharacteristic* charateristic in service.characteristics) {
        BlueCapCharacteristic* bcCharacteristic = [BlueCapCharacteristic withCBCharacteristic:charateristic andService:bcService];
        [self.discoveredObjects setObject:bcCharacteristic forKey:charateristic];
        [bcService.discoveredCharacteristics addObject:bcCharacteristic];
        [bcCharacteristic discoverDescriptors];
    }
    if ([bcService.delegate respondsToSelector:@selector(didDiscoverCharacteristicsForService:error:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [bcService.delegate didDiscoverCharacteristicsForService:bcService error:error];
        });
    }
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
    DLog(@"Discovered %d Characteristic Discriptors", [characteristic.descriptors count]);
    BlueCapCharacteristic* bcCharateristic = [self.discoveredObjects objectForKey:characteristic];
    for (CBDescriptor* descriptor in characteristic.descriptors) {
        BlueCapDescriptor* bcDescriptor = [BlueCapDescriptor withCBDiscriptor:descriptor andChracteristic:bcCharateristic];
        [self.discoveredObjects setObject:bcDescriptor forKey:descriptor];
        [bcCharateristic.discoveredDiscriptors addObject:bcDescriptor];
    }
    if ([bcCharateristic.service.delegate respondsToSelector:@selector(didDiscoverDescriptorsForCharacteristic:error:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [bcCharateristic.service.delegate didDiscoverDescriptorsForCharacteristic:bcCharateristic error:error];
        });
    }
}

- (void)peripheral:(CBPeripheral*)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
    DLog(@"Updated notification state for characteristic: %@", characteristic.UUID.stringValue);
    BlueCapCharacteristic* bcCharateristic = [self.discoveredObjects objectForKey:characteristic];
    [bcCharateristic didUpdateNotificationState:error];
}

- (void)peripheral:(CBPeripheral*)peripheral didUpdateValueForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
    DLog(@"Updated value for characteristic: %@", characteristic.UUID.stringValue);
    BlueCapCharacteristic* bcCharateristic = [self.discoveredObjects objectForKey:characteristic];
    [bcCharateristic didUpdateValue:error];
}

- (void)peripheral:(CBPeripheral*)peripheral didUpdateValueForDescriptor:(CBDescriptor*)descriptor error:(NSError*)error {
    DLog(@"Updated value for discriptor: %@", descriptor.UUID.stringValue);
    BlueCapDescriptor* bcDescriptor = [self.discoveredObjects objectForKey:descriptor];
    [bcDescriptor didUpdateValue:error];
}

- (void)peripheral:(CBPeripheral*)peripheral didWriteValueForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
    DLog(@"Wrote value for characteristic: %@", characteristic.UUID.stringValue);
    BlueCapCharacteristic* bcCharateristic = [self.discoveredObjects objectForKey:characteristic];
    [bcCharateristic didWriteValue:error];
}

- (void)peripheral:(CBPeripheral*)peripheral didWriteValueForDescriptor:(CBDescriptor*)descriptor error:(NSError*)error {
    DLog(@"Wrote value for discriptor: %@", descriptor.UUID.stringValue);
    BlueCapDescriptor* bcDescriptor = [self.discoveredObjects objectForKey:descriptor];
    [bcDescriptor didWriteValue:error];
}

- (void)peripheralDidUpdateName:(CBPeripheral*)peripheral {
}

- (void)peripheralDidUpdateRSSI:(CBPeripheral*)peripheral error:(NSError*)error {
    if (error) {
        DLog(@"Error '%@' updating RSSI for peripherial: %@", [error localizedDescription], peripheral.name);
    } else {
        DLog(@"Updated RSSI for peripherial: %@", peripheral.name);
    }
}

@end
