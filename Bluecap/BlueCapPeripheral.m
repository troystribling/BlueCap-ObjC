//
//  BlueCapPeripheral.m
//  BlueCap
//
//  Created by Troy Stribling on 8/24/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheral.h"
#import "BlueCapService.h"
#import "BlueCapCharacteristic.h"
#import "BlueCapDescriptor.h"
#import "BlueCapCentralManager+Private.h"
#import "BlueCapService+Private.h"
#import "BlueCapCharacteristic+Private.h"

@interface BlueCapPeripheral () {
    CBPeripheral* cbPeripheral;
}

@property(nonatomic, retain) NSMutableDictionary* discoveredServices;

@end

@implementation BlueCapPeripheral

#pragma mark -
#pragma mark BlueCapPeripheral

+ (BlueCapPeripheral*)withCBPeripheral:(CBPeripheral*)__cbPeripheral {
    return [[BlueCapPeripheral alloc] initWithCBPeripheral:__cbPeripheral];
}

- (id)initWithCBPeripheral:(CBPeripheral*)__cbPeripheral {
    self = [super init];
    if (self) {
        cbPeripheral = __cbPeripheral;
        cbPeripheral.delegate = self;
        self.discoveredServices = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSArray*)services {
    return [self.discoveredServices allValues];
}

- (NSString*)name {
    return cbPeripheral.name;
}

- (NSUUID*)identifier {
    return cbPeripheral.identifier;
}

- (CBPeripheralState)state {
    return cbPeripheral.state;
}

- (NSNumber*)RSSI {
    [cbPeripheral readRSSI];
    return cbPeripheral.RSSI;
}

- (void)discoverAllServices {
    [cbPeripheral discoverServices:nil];
}

- (void)discoverServices:(NSArray*)__services {
    [cbPeripheral discoverServices:__services];
}

- (void)connect {
    if (cbPeripheral.state == CBPeripheralStateDisconnected) {
        [[BlueCapCentralManager sharedInstance].centralManager connectPeripheral:cbPeripheral options:nil];
    }
}

- (void)disconnect {
    if (cbPeripheral.state == CBPeripheralStateConnected) {
        [[BlueCapCentralManager sharedInstance].centralManager cancelPeripheralConnection:cbPeripheral];
    }
}

#pragma mark -
#pragma mark BlueCapPeripheral PrivateAPI

#pragma mark -
#pragma mark CBPeripheralDelegate

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverCharacteristicsForService:(CBService*)service error:(NSError*)error {
    DLog(@"Discovered %d Service Characteristics", [service.characteristics count]);
    BlueCapService* bcService = [self.discoveredServices objectForKey:service.UUID];
    for (CBCharacteristic* charateristic in service.characteristics) {
        BlueCapCharacteristic* bcCharacteristic = [BlueCapCharacteristic withCBCharacteristic:charateristic andPeripheral:self];
        [bcService.discoveredCharacteristics setObject:bcCharacteristic forKey:charateristic.UUID];
    }
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
    DLog(@"Discovered %d Characteristic Discriptors", [characteristic.descriptors count]);
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverIncludedServicesForService:(CBService*)service error:(NSError*)error {
    DLog(@"Discovered %d Included Services", [service.includedServices count]);
    if ([self.delegate respondsToSelector:@selector(peripheral:didDiscoverIncludedServicesForService:error:)]) {
    }
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverServices:(NSError*)error {
    DLog(@"Discovered %d Services", [peripheral.services count]);
    for (CBService* service in peripheral.services) {
        [self.discoveredServices setObject:[BlueCapService withCBService:service andPeripheral:self] forKey:service.UUID];
    }
    if ([self.delegate respondsToSelector:@selector(peripheral:didDiscoverServices:)]) {
        [self.delegate peripheral:self didDiscoverServices:error];
        
    }
}

- (void)peripheral:(CBPeripheral*)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
}

- (void)peripheral:(CBPeripheral*)peripheral didUpdateValueForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
}

- (void)peripheral:(CBPeripheral*)peripheral didUpdateValueForDescriptor:(CBDescriptor*)descriptor error:(NSError*)error {
}

- (void)peripheral:(CBPeripheral*)peripheral didWriteValueForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
}

- (void)peripheral:(CBPeripheral*)peripheral didWriteValueForDescriptor:(CBDescriptor*)descriptor error:(NSError*)error {
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
