//
//  BlueCapPeripheral+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 8/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheral+Private.h"
#import "BlueCapCentralManager+Private.h"

@implementation BlueCapPeripheral (Private)

@dynamic cbPeripheral;
@dynamic discoveredServices;
@dynamic definedServices;
@dynamic discoveredObjects;

@dynamic onPeriperialDisconnectCallback;
@dynamic onPeripheralConnectCallback;
@dynamic onRSSIUpdateCallback;

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
        self.definedServices = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)didDisconnectPeripheral:(BlueCapPeripheral*)__peripheral {
    if (self.onPeriperialDisconnectCallback != nil) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.onPeriperialDisconnectCallback(__peripheral);
        }];
    }
}

- (void)didConnectPeripheral:(BlueCapPeripheral*)__peripheral {
    if (self.onPeripheralConnectCallback != nil) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.onPeripheralConnectCallback(__peripheral);
        }];
    }
}

- (void)didUpdateRSSI:(BlueCapPeripheral*)__peripheral error:(NSError*)__error {
    if (self.onRSSIUpdateCallback != nil) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.onRSSIUpdateCallback(__peripheral.RSSI, __error);
        }];
    }
}

@end
