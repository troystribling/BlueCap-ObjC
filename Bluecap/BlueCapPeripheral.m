//
//  BlueCapPeripheral.m
//  BlueCap
//
//  Created by Troy Stribling on 8/24/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheral.h"
#import "BlueCapService.h"
#import "BlueCapCentralManager+Private.h"

@interface BlueCapPeripheral () {
    CBPeripheral* cbPeripheral;
}

- (void)loadServices:(NSArray*)__services;

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
        _services = [NSArray array];
    }
    return self;
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
    return cbPeripheral.RSSI;
}

- (void)readRSSI {
    [cbPeripheral readRSSI];
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

- (void)loadServices:(NSArray*)__services {
    NSMutableArray* bcservices = [NSMutableArray array];
    for (CBService* service in __services) {
        [bcservices addObject:[BlueCapService withCBService:service]];
    }
    _services = [NSArray arrayWithArray:bcservices];
}

#pragma mark -
#pragma mark CBPeripheralDelegate

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverCharacteristicsForService:(CBService*)service error:(NSError*)error {
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverIncludedServicesForService:(CBService*)service error:(NSError*)error {
    BlueCapService* bcService = [BlueCapService withCBService:service];
    DLog(@"Discovered %d Included Services", [service.includedServices count]);
    if ([self.delegate respondsToSelector:@selector(peripheral:didDiscoverIncludedServicesForService:error:)]) {
        [self.delegate peripheral:self didDiscoverIncludedServicesForService:bcService error:error];
    }
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverServices:(NSError*)error {
    DLog(@"Discovered %d Services", [peripheral.services count]);
    [self loadServices:peripheral.services];
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
        DLog(@"Erro '%@' updaing RSSI for peripherial: %@", [error localizedDescription], peripheral.name);
    } else {
        DLog(@"Updated RSSI for peripherial: %@", peripheral.name);
    }
}

@end
