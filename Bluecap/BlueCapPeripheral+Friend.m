//
//  BlueCapPeripheral+Friend.m
//  BlueCap
//
//  Created by Troy Stribling on 8/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheral+Friend.h"
#import "BlueCapCentralManager+Friend.h"

@implementation BlueCapPeripheral (Friend)

@dynamic cbPeripheral;
@dynamic discoveredServices;
@dynamic discoveredObjects;
@dynamic advertisement;

@dynamic afterPeripherialDisconnectCallback;
@dynamic afterPeripheralConnectCallback;

@dynamic currentError;
@dynamic connectionSequenceNumber;

+ (BlueCapPeripheral*)withCBPeripheral:(CBPeripheral*)__cbPeripheral {
    return [[BlueCapPeripheral alloc] initWithCBPeripheral:__cbPeripheral];
}

- (id)initWithCBPeripheral:(CBPeripheral*)__cbPeripheral {
    self = [super init];
    if (self) {
        self.cbPeripheral = __cbPeripheral;
        self.cbPeripheral.delegate = self;
        self.discoveredServices = [NSMutableDictionary dictionary];
        self.discoveredObjects = [NSMapTable weakToWeakObjectsMapTable];
        self.currentError = BLueCapPeripheralConnectionErrorNone;
        self.advertisement = [NSDictionary dictionary];
    }
    return self;
}

- (void)didDisconnectPeripheral:(BlueCapPeripheral*)__peripheral {
    if (self.currentError == BLueCapPeripheralConnectionErrorNone) {
        ASYNC_CALLBACK(self.afterPeripherialDisconnectCallback, self.afterPeripherialDisconnectCallback(__peripheral))
    } else {
        ASYNC_CALLBACK(self.afterPeripheralConnectCallback, self.afterPeripheralConnectCallback(__peripheral, [self error]))
    }
}

- (void)didConnectPeripheral:(BlueCapPeripheral*)__peripheral {
    self.connectionSequenceNumber = 0;
    ASYNC_CALLBACK(self.afterPeripheralConnectCallback, self.afterPeripheralConnectCallback(__peripheral, nil))
}

- (void)didFailToConnectPeripheral:(BlueCapPeripheral *)__peripheral withError:(NSError *)error {
    ASYNC_CALLBACK(self.afterPeripheralConnectCallback, self.afterPeripheralConnectCallback(__peripheral, error));
}

- (NSError*)error {
    NSError* errorObj = nil;
    switch (self.currentError) {
        case BLueCapPeripheralConnectionErrorTimeout:
            errorObj = [NSError errorWithDomain:@"BlueCap"
                                           code:408
                                       userInfo:@{NSLocalizedDescriptionKey: @"Connection Timeout"}];
            break;
        default:
            break;
    }
    self.currentError = BLueCapPeripheralConnectionErrorNone;
    return errorObj;
}

@end
