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
#import "BlueCapDescriptor+Private.h"

@interface BlueCapPeripheral ()

@property(nonatomic, retain) CBPeripheral*          cbPeripheral;
@property(nonatomic, retain) NSMutableDictionary*   discoveredServices;

- (BlueCapService*)findServiceForCBChracteristic:(CBCharacteristic*)__cbChracteristic;
- (BlueCapCharacteristic*)findCharacteristicForCBCharacteristic:(CBCharacteristic*)__cbCharacteristic;
- (BlueCapDescriptor*)findDecsriptorForCBDescriptor:(CBDescriptor*)__cbDescriptor;

@end

@implementation BlueCapPeripheral

#pragma mark -
#pragma mark BlueCapPeripheral

- (NSArray*)services {
    return [self.discoveredServices allValues];
}

- (NSString*)name {
    return self.cbPeripheral.name;
}

- (NSUUID*)identifier {
    return self.cbPeripheral.identifier;
}

- (CBPeripheralState)state {
    return self.cbPeripheral.state;
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

- (void)connect {
    if (self.cbPeripheral.state == CBPeripheralStateDisconnected) {
        [[BlueCapCentralManager sharedInstance].centralManager connectPeripheral:self.cbPeripheral options:nil];
    }
}

- (void)disconnect {
    if (self.cbPeripheral.state == CBPeripheralStateConnected) {
        [[BlueCapCentralManager sharedInstance].centralManager cancelPeripheralConnection:self.cbPeripheral];
    }
}

#pragma mark -
#pragma mark BlueCapPeripheral PrivateAPI

- (BlueCapService*)findServiceForCBChracteristic:(CBCharacteristic*)__cbChracteristic {
    BlueCapService* selectedService = nil;
    for (BlueCapService* service in  [self.discoveredServices allValues]) {
        if ([[service.discoveredCharacteristics allKeys] containsObject:__cbChracteristic.UUID]) {
            selectedService = service;
            break;
        }
    }
    return selectedService;
}

- (BlueCapCharacteristic*)findCharacteristicForCBCharacteristic:(CBCharacteristic*)__cbCharacteristic {
    return [[self findServiceForCBChracteristic:__cbCharacteristic].discoveredCharacteristics objectForKey:__cbCharacteristic.UUID];
}

- (BlueCapDescriptor*)findDecsriptorForCBDescriptor:(CBDescriptor*)__cbDescriptor {
    BlueCapDescriptor* selectedDescriptor = nil;
    for (BlueCapService* service in  [self.discoveredServices allValues]) {
        for (BlueCapCharacteristic* characteristic in [service.discoveredCharacteristics allValues]) {
            if ([[characteristic.discoveredDiscriptors allKeys] containsObject:__cbDescriptor.UUID]) {
                selectedDescriptor = [characteristic.discoveredDiscriptors objectForKey:__cbDescriptor.UUID];
                break;
            }
        }
    }
    return selectedDescriptor;
}

#pragma mark -
#pragma mark CBPeripheralDelegate

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverCharacteristicsForService:(CBService*)service error:(NSError*)error {
    DLog(@"Discovered %d Service Characteristics", [service.characteristics count]);
    BlueCapService* bcService = [self.discoveredServices objectForKey:service.UUID];
    for (CBCharacteristic* charateristic in service.characteristics) {
        BlueCapCharacteristic* bcCharacteristic = [BlueCapCharacteristic withCBCharacteristic:charateristic andService:bcService];
        [bcService.discoveredCharacteristics setObject:bcCharacteristic forKey:charateristic.UUID];
        [bcCharacteristic discoverDescriptors];
    }
    if ([bcService.delegate respondsToSelector:@selector(didDiscoverCharacteristicsForService:error:)]) {
        [bcService.delegate didDiscoverCharacteristicsForService:bcService error:error];
    }
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
    DLog(@"Discovered %d Characteristic Discriptors", [characteristic.descriptors count]);
    BlueCapService* bcService = [self findServiceForCBChracteristic:characteristic];
    BlueCapCharacteristic* bcCharateristic = [bcService.discoveredCharacteristics objectForKey:characteristic.UUID];
    for (CBDescriptor* descriptor in characteristic.descriptors) {
        BlueCapDescriptor* bcDescriptor = [BlueCapDescriptor withCBDiscriptor:descriptor andChracteristic:bcCharateristic];
        [bcCharateristic.discoveredDiscriptors setObject:bcDescriptor forKey:descriptor.UUID];
    }
    if ([bcService.delegate respondsToSelector:@selector(didDiscoverDescriptorsForCharacteristic:error:)]) {
        [bcService.delegate didDiscoverDescriptorsForCharacteristic:bcCharateristic error:error];
    }
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
    BlueCapCharacteristic* bcCharateristic = [self findCharacteristicForCBCharacteristic:characteristic];
    [bcCharateristic didUpdateNotificationState:error];
}

- (void)peripheral:(CBPeripheral*)peripheral didUpdateValueForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
    BlueCapCharacteristic* bcCharateristic = [self findCharacteristicForCBCharacteristic:characteristic];
    [bcCharateristic didWriteValue:error];
}

- (void)peripheral:(CBPeripheral*)peripheral didUpdateValueForDescriptor:(CBDescriptor*)descriptor error:(NSError*)error {
    BlueCapDescriptor* bcDescriptor = [self findDecsriptorForCBDescriptor:descriptor];
    [bcDescriptor didUpdateValue:error];
}

- (void)peripheral:(CBPeripheral*)peripheral didWriteValueForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
    BlueCapCharacteristic* bcCharateristic = [self findCharacteristicForCBCharacteristic:characteristic];
    [bcCharateristic didWriteValue:error];
}

- (void)peripheral:(CBPeripheral*)peripheral didWriteValueForDescriptor:(CBDescriptor*)descriptor error:(NSError*)error {
    BlueCapDescriptor* bcDescriptor = [self findDecsriptorForCBDescriptor:descriptor];
    [bcDescriptor didUpdateValue:error];
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
