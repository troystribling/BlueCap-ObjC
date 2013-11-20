//
//  BlueCapPeripheralManager.m
//  BlueCap
//
//  Created by Troy Stribling on 11/3/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheralManager+Friend.h"
#import "BlueCapMutableService+Friend.h"
#import "BlueCapMutableCharacteristic+Friend.h"
#import "BlueCapCharacteristicProfile+Friend.h"
#import "CBUUID+StringValue.h"

#define WAIT_FOR_ADVERTISING_TO_STOP_POLLING_INTERVAL   0.25

static BlueCapPeripheralManager* thisBlueCapPeripheralManager = nil;

@interface BlueCapPeripheralManager()

@property(nonatomic, retain) CBPeripheralManager*                       cbPeripheralManager;
@property(nonatomic, retain) dispatch_queue_t                           mainQueue;
@property(nonatomic, retain) dispatch_queue_t                           callbackQueue;
@property(nonatomic, retain) NSMutableDictionary*                       configuredServices;
@property(nonatomic, retain) NSMapTable*                                configuredCharacteristics;
@property(nonatomic, copy) BlueCapPeripheralManagerCallback             afterStartedAdvertisingCallback;
@property(nonatomic, copy) BlueCapPeripheralManagerCallback             afterStoppedAdvertisingCallback;
@property(nonatomic, copy) BlueCapPeripheralManagerCallback             afterPowerOnCallback;
@property(nonatomic, copy) BlueCapPeripheralManagerCallback             afterPowerOffCallback;
@property(nonatomic, copy) BlueCapPeripheralManagerAfterServiceAdded    afterServiceAddedCallback;
@property(nonatomic, assign) BOOL                                       poweredOn;

- (void)waitForAdvertisingToStop;

@end

@implementation BlueCapPeripheralManager

#pragma mark - BlueCapPeriheralManager

+(BlueCapPeripheralManager*)sharedInstance {
    @synchronized(self) {
        if (thisBlueCapPeripheralManager == nil) {
            thisBlueCapPeripheralManager = [[self alloc] init];
        }
    }
    return thisBlueCapPeripheralManager;
}

- (id)init {
    self = [super init];
    if (self) {
        self.mainQueue = dispatch_queue_create("com.gnos.us.peripheral.main", DISPATCH_QUEUE_SERIAL);
        self.callbackQueue = dispatch_queue_create("com.gnos.us.perpheral.callback", DISPATCH_QUEUE_SERIAL);
        self.cbPeripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:self.mainQueue];
        self.configuredServices = [NSMutableDictionary dictionary];
        self.poweredOn = NO;
        self.configuredCharacteristics = [NSMapTable weakToWeakObjectsMapTable];
    }
    return self;
}

- (BOOL)isAdvertising {
    return self.cbPeripheralManager.isAdvertising;
}

- (CBPeripheralManagerState)state {
    return self.cbPeripheralManager.state;
}

- (NSArray*)services {
    return [self.configuredServices allValues];
}

- (void)startAdvertising:(NSString*)__name afterStart:(BlueCapPeripheralManagerCallback)__startedAdvertisingCallback {
    if ([self.services count] > 0) {
        self.afterStartedAdvertisingCallback = __startedAdvertisingCallback;
        [self.cbPeripheralManager startAdvertising:@{CBAdvertisementDataLocalNameKey:__name,
                                                     CBAdvertisementDataServiceUUIDsKey:[self.configuredServices allKeys]}];
    } else {
        [NSException raise:@"No services configured" format:@"service array is empty"];
    }
}

- (void)stopAdvertising:(BlueCapPeripheralManagerCallback)__stoppedAdvertisingCallback {
    self.afterStoppedAdvertisingCallback = __stoppedAdvertisingCallback;
    [self.cbPeripheralManager stopAdvertising];
    [self waitForAdvertisingToStop];
}

- (void)addService:(BlueCapMutableService*)__service whenCompleteCall:(BlueCapPeripheralManagerAfterServiceAdded)__afterServiceAddedCallback {
    self.afterServiceAddedCallback = __afterServiceAddedCallback;
    [self.configuredServices setObject:__service forKey:__service.UUID];
    [self.cbPeripheralManager addService:__service.cbService];
}

- (void)removeService:(BlueCapMutableService*)__service {
    [self.configuredServices removeObjectForKey:__service.UUID];
    [self.cbPeripheralManager removeService:__service.cbService];
}

- (void)removeAllServices {
    [self.configuredServices removeAllObjects];
    [self.cbPeripheralManager removeAllServices];
}

#pragma mark - Power On

- (void)powerOn:(BlueCapPeripheralManagerCallback)__afterPowerOnCallback {
    self.afterPowerOnCallback = __afterPowerOnCallback;
    [self syncMain:^{
        if (self.poweredOn && self.afterPowerOnCallback) {
            [self asyncCallback:^{
                self.afterPowerOnCallback();
            }];
        }
    }];
}

- (void)powerOn:(BlueCapPeripheralManagerCallback)__onPowerOnCallback afterPowerOff:(BlueCapPeripheralManagerCallback)__afterPowerOffCallback {
    self.afterPowerOffCallback = __afterPowerOffCallback;
    [self powerOn:__onPowerOnCallback];
}


#pragma mark - Private

- (void)waitForAdvertisingToStop {
    if (self.isAdvertising) {
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(WAIT_FOR_ADVERTISING_TO_STOP_POLLING_INTERVAL * NSEC_PER_SEC));
        dispatch_after(popTime, self.callbackQueue, ^{
            [self waitForAdvertisingToStop];
        });
    } else {
        [self asyncCallback:^{
            DLog(@"Peripheral Manager did stop advertising");
            self.afterStoppedAdvertisingCallback();
        }];
    }
}

#pragma mark - BlueCapPeripheralManagerDelegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager*)peripheral {
    switch (self.state) {
        case CBPeripheralManagerStatePoweredOn: {
            DLog(@"CBPeripheralManager PoweredOn");
            self.poweredOn = YES;
            if (self.afterPowerOnCallback) {
                [self asyncCallback:^{
                    self.afterPowerOnCallback();
                }];
            }
            break;
        }
        case CBPeripheralManagerStatePoweredOff: {
            self.poweredOn = NO;
            if (self.afterPowerOffCallback) {
                [self asyncCallback:^{
                    self.afterPowerOffCallback();
                }];
            }
            break;
        }
        case CBPeripheralManagerStateResetting: {
            break;
        }
        case CBPeripheralManagerStateUnsupported: {
            break;
        }
        case CBPeripheralManagerStateUnauthorized: {
            break;
        }
        case CBPeripheralManagerStateUnknown: {
            break;
        }
    }
}

- (void)peripheralManager:(CBPeripheralManager*)peripheral didAddService:(CBService*)service error:(NSError*)error {
    BlueCapMutableService* bcService = [self.configuredServices objectForKey:service.UUID];
    DLog(@"Peripheral Manager did add sevice: %@:%@", bcService.name, [service.UUID stringValue]);
    for (CBMutableCharacteristic* characteristic in service.characteristics) {
        DLog(@"Peripheral Manager did add characteristic: %@", [characteristic.UUID stringValue]);
        uint8_t val = 0x01;
        [peripheral updateValue:[NSData dataWithBytes:&val length:1] forCharacteristic:characteristic onSubscribedCentrals:nil];
    }
    [[BlueCapPeripheralManager sharedInstance] asyncCallback:^{
        self.afterServiceAddedCallback(bcService, error);
    }];
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager*)peripheral error:(NSError*)error {
    DLog(@"Peripheral Manager did start advertising");
    [[BlueCapPeripheralManager sharedInstance] asyncCallback:^{
        self.afterStartedAdvertisingCallback();
    }];
}

- (void)peripheralManager:(CBPeripheralManager*)peripheral central:(CBCentral*)central didSubscribeToCharacteristic:(CBCharacteristic*)characteristic {
}

- (void)peripheralManager:(CBPeripheralManager*)peripheral central:(CBCentral*)central didUnsubscribeFromCharacteristic:(CBCharacteristic*)characteristic {
}

- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager*)peripheral {
}

- (void)peripheralManager:(CBPeripheralManager*)peripheral didReceiveReadRequest:(CBATTRequest*)request {
    DLog(@"Characteristic %@ did recieve read request", [request.characteristic.UUID stringValue]);
    BlueCapMutableCharacteristic* characteristic = [self.configuredCharacteristics objectForKey:request.characteristic];
    if (characteristic != nil) {
        request.value = [characteristic dataValue];
        [self.cbPeripheralManager respondToRequest:request withResult:CBATTErrorSuccess];
    } else {
        DLog(@"characteristic not found");
    }
}

- (void)peripheralManager:(CBPeripheralManager*)peripheral didReceiveWriteRequests:(NSArray*)requests {
    for (CBATTRequest* request in requests) {
        DLog(@"Characteristic %@ did receive write request", [request.characteristic.UUID stringValue]);
        BlueCapMutableCharacteristic* characteristic = [self.configuredCharacteristics objectForKey:request.characteristic];
        if (characteristic) {
            characteristic.cbCharacteristic.value = request.value;
            if (characteristic.processWriteCallback) {
                characteristic.processWriteCallback(characteristic);
            }
        } else {
            DLog(@"characteristic not found");
        }
    }
}

@end
