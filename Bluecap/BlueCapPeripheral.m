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
#import "BlueCapProfileManager+Friend.h"
#import "CBUUID+StringValue.h"

#define RSSI_UPDATE_PERIOD_SEC          0.5
#define PERIPHERAL_CONNECTION_TIMEOUT   10

@interface BlueCapPeripheral ()

@property(nonatomic, retain) CBPeripheral*      cbPeripheral;
@property(nonatomic, retain) NSMutableArray*    discoveredServices;
@property(nonatomic, retain) NSMapTable*        discoveredObjects;
@property(nonatomic, retain) NSDictionary*      advertisement;

@property(nonatomic, copy) BlueCapPeripheralDisconnectCallback  afterPeriperialDisconnectCallback;
@property(nonatomic, copy) BlueCapPeripheralConnectCallback     afterPeripheralConnectCallback;
@property(nonatomic, copy) BlueCapServicesDiscoveredCallback    afterServicesDiscoveredCallback;
@property(nonatomic, copy) BlueCapPeripheralRSSICallback        afterRSSIUpdateCallback;

@property(nonatomic, assign) BLueCapPeripheralConnectionError   currentError;

- (void)clearServices;
- (void)clearCharacteristics:(BlueCapService*)__service;
- (void)clearDescriptors:(BlueCapCharacteristic*)__chraracteristics;

- (void)readRSSI;
- (void)timeoutConnection;

@end

@implementation BlueCapPeripheral

#pragma mark - BlueCapPeripheral

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
    return self.cbPeripheral.RSSI;
}

- (NSDictionary*)advertisement {
    return _advertisement;
}

#pragma mark - Discover Services

- (void)discoverAllServices:(BlueCapServicesDiscoveredCallback)__afterServicesDiscoveredCallback {
    self.afterServicesDiscoveredCallback = __afterServicesDiscoveredCallback;
    [self.cbPeripheral discoverServices:nil];
}

- (void)discoverServices:(NSArray*)__services afterDiscovery:(BlueCapServicesDiscoveredCallback)__afterServicesDiscoveredCallback {
    self.afterServicesDiscoveredCallback = __afterServicesDiscoveredCallback;
    [self.cbPeripheral discoverServices:__services];
}

#pragma mark - RSSI Updates

- (void)recieveRSSIUpdates:(BlueCapPeripheralRSSICallback)__afterRSSIUpdate {
    [[BlueCapCentralManager sharedInstance] asyncCallback:^{
        if (self.afterRSSIUpdateCallback == nil) {
            self.afterRSSIUpdateCallback = __afterRSSIUpdate;
            [self readRSSI];
        }
    }];
}

- (void)dropRSSIUpdates {
    [[BlueCapCentralManager sharedInstance] asyncCallback:^{
        self.afterRSSIUpdateCallback = nil;
    }];
}

#pragma mark - Connect/Disconnect Peripheral

- (void)connect:(BlueCapPeripheralConnectCallback)__afterPeripheralConnect {
    if (self.cbPeripheral.state != CBPeripheralStateConnected) {
        self.afterPeripheralConnectCallback = __afterPeripheralConnect;
        [[BlueCapCentralManager sharedInstance].centralManager connectPeripheral:self.cbPeripheral options:nil];
        [self timeoutConnection];
    }
}

- (void)disconnect:(BlueCapPeripheralDisconnectCallback)__afterPeripheralDisconnect {
    if (self.cbPeripheral.state == CBPeripheralStateConnected) {
        self.currentError = BLueCapPeripheralConnectionErrorNone;
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

#pragma mark - BlueCapPeripheral PrivateAPI

- (void)clearServices {
    DLog(@"CLEAR SERVICES BEFORE COUNT: %d", [self.discoveredObjects count]);
    for (BlueCapService* service in self.discoveredServices) {
        [self.discoveredObjects removeObjectForKey:service.cbService];
    }
    [self.discoveredServices removeAllObjects];
    DLog(@"CLEAR SERVICES AFTER COUNT: %d", [self.discoveredObjects count]);
}

- (void)clearCharacteristics:(BlueCapService*)service {
    DLog(@"CLEAR CHARACTERISTICS BEFORE COUNT: %d", [self.discoveredObjects count]);
    for (BlueCapCharacteristic* characteristic in service.discoveredCharacteristics) {
        [self.discoveredObjects removeObjectForKey:characteristic.cbCharacteristic];
    }
    [service.discoveredCharacteristics removeAllObjects];
    DLog(@"CLEAR CHARACTERISTICS AFTER COUNT: %d", [self.discoveredObjects count]);
}

- (void)clearDescriptors:(BlueCapCharacteristic*)chraracteristic {
    DLog(@"CLEAR DESCRIPTORS BEFORE COUNT: %d", [self.discoveredObjects count]);
    for (BlueCapDescriptor* descriptor in chraracteristic.discoveredDiscriptors) {
        [self.discoveredObjects removeObjectForKey:descriptor.cbDescriptor];
    }
    [chraracteristic.discoveredDiscriptors removeAllObjects];
    DLog(@"CLEAR DESCRIPTORS AFTER COUNT: %d", [self.discoveredObjects count]);
}

- (void)readRSSI {
    if (self.state == CBPeripheralStateConnected) {
        [self.cbPeripheral readRSSI];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(RSSI_UPDATE_PERIOD_SEC * NSEC_PER_SEC));
        dispatch_after(popTime, [BlueCapCentralManager sharedInstance].callbackQueue, ^(void) {
            if (self.afterRSSIUpdateCallback) {
                [self readRSSI];
            }
        });
    }
}

- (void)timeoutConnection {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(PERIPHERAL_CONNECTION_TIMEOUT * NSEC_PER_SEC));
    dispatch_after(popTime, [BlueCapCentralManager sharedInstance].callbackQueue, ^(void) {
        if (self.state != CBPeripheralStateConnected) {
            DLog(@"PERIPHERAL '%@' TIMEOUT", self.name);
            self.currentError = BLueCapPeripheralConnectionErrorTimeout;
            [[BlueCapCentralManager sharedInstance].centralManager cancelPeripheralConnection:self.cbPeripheral];
        }
    });
}

#pragma mark - CBPeripheralDelegate

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverServices:(NSError*)error {
    DLog(@"Discovered %d Services", [peripheral.services count]);
    [self clearServices];
    for (CBService* service in peripheral.services) {
        BlueCapService* bcService = [BlueCapService withCBService:service andPeripheral:self];
        DLog(@"Discovered Service: %@", [bcService.UUID stringValue]);
        [self.discoveredObjects setObject:bcService forKey:service];
        [self.discoveredServices addObject:bcService];
        BlueCapServiceProfile* serviceProfile = [[BlueCapProfileManager sharedInstance].configuredServiceProfiles objectForKey:bcService.UUID];
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
            BlueCapCharacteristicProfile* characteristicProfile = [bcService.profile.characteristicProfilesDictionary objectForKey:bcCharacteristic.UUID];
            if (characteristicProfile) {
                DLog(@"Characteristic Profile Found: %@", characteristicProfile.name);
                bcCharacteristic.profile = characteristicProfile;
                if (characteristicProfile.afterDiscoveredCallback) {
                    [[BlueCapCentralManager sharedInstance] asyncCallback:^{
                        bcCharacteristic.profile.afterDiscoveredCallback(bcCharacteristic);
                    }];
                }
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

- (void)peripheralDidUpdateRSSI:(CBPeripheral*)peripheral error:(NSError*)__error {
    if (self.afterRSSIUpdateCallback != nil) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.afterRSSIUpdateCallback(self, __error);
        }];
    }
}

@end
