//
//  BlueCapPeripheral.m
//  BlueCap
//
//  Created by Troy Stribling on 8/24/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheral.h"

@interface BlueCapPeripheral () {
    CBPeripheral* cbPeripheral;
}

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

#pragma mark -
#pragma mark BlueCapPeripheral PrivateAPI

#pragma mark -
#pragma mark CBPeripheralDelegate

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverCharacteristicsForService:(CBService*)service error:(NSError*)error {
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverIncludedServicesForService:(CBService*)service error:(NSError*)error {
    DLog(@"Discovered %d Included Services", [service.includedServices count]);
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverServices:(NSError*)error {
    DLog(@"Discovered %d Services", [peripheral.services count]);
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

@end
