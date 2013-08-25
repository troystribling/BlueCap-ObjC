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

@property(nonatomic, retain) NSMutableArray* discoveredServices;

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
        self.discoveredServices = [NSMutableArray array];
    }
    return self;
}

- (NSArray*)services {
    return [NSArray arrayWithArray:self.discoveredServices];
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

- (void)loadServices:(NSArray*)__services {
    for (CBService* service in __services) {
        [self.discoveredServices addObject:[BlueCapService withCBService:service]];
    }
}

#pragma mark -
#pragma mark CBPeripheralDelegate

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverCharacteristicsForService:(CBService*)service error:(NSError*)error {
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverIncludedServicesForService:(CBService*)service error:(NSError*)error {
    DLog(@"Discovered %d Included Services", [service.includedServices count]);
    if ([self.delegate respondsToSelector:@selector(peripheral:didDiscoverIncludedServicesForService:error:)]) {
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
        DLog(@"Error '%@' updating RSSI for peripherial: %@", [error localizedDescription], peripheral.name);
    } else {
        DLog(@"Updated RSSI for peripherial: %@", peripheral.name);
    }
}

@end
