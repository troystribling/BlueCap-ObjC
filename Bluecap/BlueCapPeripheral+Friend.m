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

@dynamic afterPeriperialDisconnectCallback;
@dynamic afterPeripheralConnectCallback;

@dynamic currentError;
@dynamic connectionSequenceNumber;
@dynamic autoReconnect;

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
        self.currentError = BLueCapPeripheralConnectionErrorDisconnected;
        self.advertisement = [NSDictionary dictionary];
        self.autoReconnect = NO;
    }
    return self;
}

- (void)didDisconnectPeripheral:(BlueCapPeripheral*)__peripheral {
    if (self.currentError == BLueCapPeripheralConnectionErrorNone) {
        if (self.afterPeriperialDisconnectCallback != nil) {
            self.afterPeriperialDisconnectCallback(__peripheral);
        }
    } else {
        if (self.autoReconnect) {
            if (self.afterPeriperialDisconnectCallback != nil) {
                [[BlueCapCentralManager sharedInstance] asyncCallback:^{
                    self.afterPeriperialDisconnectCallback(__peripheral);
                }];
            }
        }
        if (self.afterPeripheralConnectCallback != nil) {
            [[BlueCapCentralManager sharedInstance] asyncCallback:^{
                self.afterPeripheralConnectCallback(__peripheral, [self error]);
            }];
        }
    }
}

- (void)didConnectPeripheral:(BlueCapPeripheral*)__peripheral {
    [[BlueCapCentralManager sharedInstance] asyncCallback:^{
        self.connectionSequenceNumber = 0;
    }];
    if (self.afterPeripheralConnectCallback != nil) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.afterPeripheralConnectCallback(__peripheral, nil);
        }];
    }
}

- (NSError*)error {
    NSError* errorObj = nil;
    switch (self.currentError) {
        case BLueCapPeripheralConnectionErrorDisconnected:
            [NSError errorWithDomain:@"BlueCap"
                                code:500
                            userInfo:@{NSLocalizedDescriptionKey: @"Disconnected"}];
            break;
        case BLueCapPeripheralConnectionErrorTimeout:
            [NSError errorWithDomain:@"BlueCap"
                                code:408
                            userInfo:@{NSLocalizedDescriptionKey: @"Connection Timeout"}];
            break;
        default:
            break;
    }
    self.currentError = BLueCapPeripheralConnectionErrorDisconnected;
    return errorObj;
}

@end
