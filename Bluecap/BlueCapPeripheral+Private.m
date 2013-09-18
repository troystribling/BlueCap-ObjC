//
//  BlueCapPeripheral+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 8/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheral+Private.h"

@implementation BlueCapPeripheral (Private)

@dynamic cbPeripheral;
@dynamic discoveredServices;
@dynamic discoveredObjects;

@dynamic onPeriperialDisconnect;
@dynamic onPeripheralConnect;
@dynamic onRSSIUpdate;

+ (BlueCapPeripheral*)withCBPeripheral:(CBPeripheral*)__cbPeripheral {
    return [[BlueCapPeripheral alloc] initWithCBPeripheral:__cbPeripheral];
}

- (id)initWithCBPeripheral:(CBPeripheral*)__cbPeripheral {
    self = [super init];
    if (self) {
        self.cbPeripheral = __cbPeripheral;
        self.cbPeripheral.delegate = self;
        self.discoveredServices = [NSMutableArray array];
        self.discoveredObjects = [NSMapTable weakToWeakObjectsMapTable];
    }
    return self;
}

- (void)didDisconnectPeripheral:(BlueCapPeripheral*)__peripheral {
    if (self.onPeriperialDisconnect != nil) {
        self.onPeriperialDisconnect(__peripheral);
        self.onPeriperialDisconnect = nil;
    }
}

- (void)didConnectPeripheral:(BlueCapPeripheral*)__peripheral {
    if (self.onPeripheralConnect != nil) {
        self.onPeripheralConnect(__peripheral);
        self.onPeripheralConnect = nil;
    }
}

- (void)didUpdateRSSI:(BlueCapPeripheral*)__peripheral error:(NSError*)__error {
    if (self.onRSSIUpdate != nil) {
        self.onRSSIUpdate(__peripheral.RSSI, __error);
        self.onRSSIUpdate = nil;
    }
}

@end
