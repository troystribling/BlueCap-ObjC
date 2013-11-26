//
//  BlueCapPeripheral+Friend.m
//  BlueCap
//
//  Created by Troy Stribling on 8/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheral+Friend.h"
#import "BlueCapCentralManager+Friend.h"

#define PERIPHERAL_CONNECTION_TIMEOUT   10

@implementation BlueCapPeripheral (Friend)

@dynamic cbPeripheral;
@dynamic discoveredServices;
@dynamic discoveredObjects;
@dynamic advertisement;

@dynamic afterPeriperialDisconnectCallback;
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
        self.discoveredServices = [NSMutableArray array];
        self.discoveredObjects = [NSMapTable weakToWeakObjectsMapTable];
        self.currentError = BLueCapPeripheralConnectionErrorDisconnected;
        self.advertisement = [NSDictionary dictionary];
    }
    return self;
}

- (void)didDisconnectPeripheral:(BlueCapPeripheral*)__peripheral {
    if (self.currentError == BLueCapPeripheralConnectionErrorNone) {
        if (self.afterPeriperialDisconnectCallback != nil) {
            self.afterPeriperialDisconnectCallback(__peripheral);
        }
    } else {
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

- (void)timeoutConnection:(NSInteger)__sequenceNumber {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(PERIPHERAL_CONNECTION_TIMEOUT * NSEC_PER_SEC));
    dispatch_after(popTime, [BlueCapCentralManager sharedInstance].callbackQueue, ^(void) {
        DLog(@"Sequence Number:%d, this sequence number: %d, state: %d", self.connectionSequenceNumber, __sequenceNumber, self.state);
        if (self.state != CBPeripheralStateConnected && __sequenceNumber == self.connectionSequenceNumber) {
            DLog(@"PERIPHERAL '%@' TIMEOUT", self.name);
            self.currentError = BLueCapPeripheralConnectionErrorTimeout;
            [[BlueCapCentralManager sharedInstance].centralManager cancelPeripheralConnection:self.cbPeripheral];
        }
    });
}

@end
