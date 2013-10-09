//
//  BlueCapPeripheral.m
//  BlueCap
//
//  Created by Troy Stribling on 8/24/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCentralManager+Friend.h"
#import "BlueCapPeripheral+Friend.h"
#import "BlueCapService+Friend.h"
#import "BlueCapCharacteristic+Friend.h"
#import "BlueCapDescriptor+Friend.h"
#import "BlueCapServiceProfile+Friend.h"
#import "BlueCapCharacteristicProfile+Friend.h"
#import "CBUUID+StringValue.h"

@interface BlueCapPeripheral ()

@property(nonatomic, retain) CBPeripheral*                  cbPeripheral;
@property(nonatomic, retain) NSMutableArray*                discoveredServices;
@property(nonatomic, retain) NSMapTable*                    discoveredObjects;

@property(nonatomic, copy) BlueCapPeripheralCallback            afterPeriperialDisconnectCallback;
@property(nonatomic, copy) BlueCapPeripheralCallback            afterPeripheralConnectCallback;
@property(nonatomic, copy) BlueCapServicesDiscoveredCallback    afterServicesDiscoveredCallback;
@property(nonatomic, copy) BlueCapPeripheralRSSICallback        afterRSSIUpdate;

- (void)clearServices;
- (void)clearCharacteristics:(BlueCapService*)__service;
- (void)clearDescriptors:(BlueCapCharacteristic*)__chraracteristics;

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

#pragma mark -
#pragma mark Discover Services

- (void)discoverAllServices:(BlueCapServicesDiscoveredCallback)__afterServicesDiscoveredCallback {
    self.afterServicesDiscoveredCallback = __afterServicesDiscoveredCallback;
    [self.cbPeripheral discoverServices:nil];
}

- (void)discoverServices:(NSArray*)__services onDiscovery:(BlueCapServicesDiscoveredCallback)__afterServicesDiscoveredCallback {
    self.afterServicesDiscoveredCallback = __afterServicesDiscoveredCallback;
    [self.cbPeripheral discoverServices:__services];
}

#pragma mark -
#pragma mark Connect/Disconnect Peripheral

- (void)connect:(BlueCapPeripheralCallback)__afterPeripheralConnect {
    if (self.cbPeripheral.state == CBPeripheralStateDisconnected) {
        self.afterPeripheralConnectCallback = __afterPeripheralConnect;
        [[BlueCapCentralManager sharedInstance].centralManager connectPeripheral:self.cbPeripheral options:nil];
    }
}

- (void)disconnect:(BlueCapPeripheralCallback)__afterPeripheralDisconnect {
    if (self.cbPeripheral.state == CBPeripheralStateConnected) {
        self.afterPeriperialDisconnectCallback = __afterPeripheralDisconnect;
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

- (void)clearServices {
    DLog(@"BEFORE COUNT: %d", [self.discoveredObjects count]);
    for (BlueCapService* service in self.discoveredServices) {
        [self.discoveredObjects removeObjectForKey:service.cbService];
    }
    [self.discoveredServices removeAllObjects];
    DLog(@"AFTER COUNT: %d", [self.discoveredObjects count]);
}

- (void)clearCharacteristics:(BlueCapService*)service {
    DLog(@"BEFORE COUNT: %d", [self.discoveredObjects count]);
    for (BlueCapCharacteristic* characteristic in service.discoveredCharacteristics) {
        [self.discoveredObjects removeObjectForKey:characteristic.cbCharacteristic];
    }
    [service.discoveredCharacteristics removeAllObjects];
    DLog(@"AFTER COUNT: %d", [self.discoveredObjects count]);
}

- (void)clearDescriptors:(BlueCapCharacteristic*)chraracteristic {
    DLog(@"BEFORE COUNT: %d", [self.discoveredObjects count]);
    for (BlueCapDescriptor* descriptor in chraracteristic.discoveredDiscriptors) {
        [self.discoveredObjects removeObjectForKey:descriptor.cbDescriptor];
    }
    [chraracteristic.discoveredDiscriptors removeAllObjects];
    DLog(@"AFTER COUNT: %d", [self.discoveredObjects count]);
}

#pragma mark -
#pragma mark CBPeripheralDelegate

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverServices:(NSError*)error {
    DLog(@"Discovered %d Services", [peripheral.services count]);
    [self clearServices];
    for (CBService* service in peripheral.services) {
        BlueCapService* bcService = [BlueCapService withCBService:service andPeripheral:self];
        DLog(@"Discovered Service: %@", [bcService.UUID stringValue]);
        [self.discoveredObjects setObject:bcService forKey:service];
        [self.discoveredServices addObject:bcService];
        BlueCapServiceProfile* serviceProfile = [[BlueCapCentralManager sharedInstance].serviceProfiles objectForKey:bcService.UUID];
        if (serviceProfile) {
            DLog(@"Service Profile Found: %@", serviceProfile.name);
            bcService.profile = serviceProfile;
        }
    }
    if (self.afterServicesDiscoveredCallback) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.afterServicesDiscoveredCallback(self.discoveredServices);
        }];
    }
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverIncludedServicesForService:(CBService*)service error:(NSError*)error {
    DLog(@"Discovered %d Included Services", [service.includedServices count]);
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverCharacteristicsForService:(CBService*)service error:(NSError*)error {
    DLog(@"Discovered %d Service Characteristics", [service.characteristics count]);
    BlueCapService* bcService = [self.discoveredObjects objectForKey:service];
    [self clearCharacteristics:bcService];
    for (CBCharacteristic* charateristic in service.characteristics) {
        BlueCapCharacteristic* bcCharacteristic = [BlueCapCharacteristic withCBCharacteristic:charateristic andService:bcService];
        DLog(@"Discovered Characteristic: %@", [bcCharacteristic.UUID stringValue]);
        [self.discoveredObjects setObject:bcCharacteristic forKey:charateristic];
        [bcService.discoveredCharacteristics addObject:bcCharacteristic];
        if ([bcService hasProfile]) {
            BlueCapCharacteristicProfile* characteristicProfile = [bcService.profile.characteristicProfiles objectForKey:bcCharacteristic.UUID];
            if (characteristicProfile) {
                DLog(@"Characteristic Profile Found: %@", characteristicProfile.name);
                bcCharacteristic.profile = characteristicProfile;
                bcCharacteristic.profile.afterDiscoveredCallback(bcCharacteristic);
            }
        }
    }
    [bcService didDiscoverCharacterics:bcService.discoveredCharacteristics];
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
    DLog(@"Discovered %d Characteristic Discriptors", [characteristic.descriptors count]);
    BlueCapCharacteristic* bcCharateristic = [self.discoveredObjects objectForKey:characteristic];
    [self clearDescriptors:bcCharateristic];
    for (CBDescriptor* descriptor in characteristic.descriptors) {
        BlueCapDescriptor* bcDescriptor = [BlueCapDescriptor withCBDiscriptor:descriptor andChracteristic:bcCharateristic];
        [self.discoveredObjects setObject:bcDescriptor forKey:descriptor];
        [bcCharateristic.discoveredDiscriptors addObject:bcDescriptor];
    }
    [bcCharateristic didDiscoverDescriptors:bcCharateristic.discoveredDiscriptors];
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
