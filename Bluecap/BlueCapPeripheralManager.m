//
//  BlueCapPeripheralManager.m
//  BlueCap
//
//  Created by Troy Stribling on 11/3/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheralManager+Friend.h"
#import "BlueCapMutableService+Friend.h"

#define WAIT_FOR_ADVERTISING_TO_STOP_POLLING_INTERVAL   0.25

static BlueCapPeripheralManager* thisBlueCapPeripheralManager = nil;

@interface BlueCapPeripheralManager()

@property(nonatomic, retain) CBPeripheralManager*                       cbPeripheralManager;
@property(nonatomic, retain) dispatch_queue_t                           mainQueue;
@property(nonatomic, retain) dispatch_queue_t                           callbackQueue;
@property(nonatomic, retain) NSMutableDictionary*                       configuredServices;
@property(nonatomic, copy) BlueCapPeripheralManagerStartedAdvertising   startedAdvertisingCallback;
@property(nonatomic, copy) BlueCapPeripheralManagerStoppedAdvertising   stoppedAdvertisingCallback;
@property(nonatomic, copy) BlueCapPeripheralManagerAfterServiceAdded    afterServiceAddedCallback;

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

- (void)startAdvertising:(NSString*)__name afterStart:(BlueCapPeripheralManagerStartedAdvertising)__startedAdvertisingCallback {
    if ([self.services count] > 0) {
        self.startedAdvertisingCallback = __startedAdvertisingCallback;
        [self.cbPeripheralManager startAdvertising:@{CBAdvertisementDataLocalNameKey:__name,
                                                     CBAdvertisementDataServiceUUIDsKey:[self.configuredServices allKeys]}];
    } else {
        [NSException raise:@"No services configured" format:@"service array is empty"];
    }
}

- (void)stopAdvertising:(BlueCapPeripheralManagerStoppedAdvertising)__stoppedAdvertisingCallback {
    self.stoppedAdvertisingCallback = __stoppedAdvertisingCallback;
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
            self.stoppedAdvertisingCallback(self);
        }];
    }
}

#pragma mark - BlueCapPeripheralManagerDelegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager*)peripheral {
}

- (void)peripheralManager:(CBPeripheralManager*)peripheral didAddService:(CBService*)service error:(NSError*)error {
    BlueCapMutableService* bcService = [self.configuredServices objectForKey:service.UUID];
    DLog(@"Peripheral Manager did add sevice: %@", bcService.name);
    [[BlueCapPeripheralManager sharedInstance] asyncCallback:^{
        self.afterServiceAddedCallback(bcService, error);
    }];
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager*)peripheral error:(NSError*)error {
    DLog(@"Peripheral Manager did start advertising");
    [[BlueCapPeripheralManager sharedInstance] asyncCallback:^{
        self.startedAdvertisingCallback(self);
    }];
}

- (void)peripheralManager:(CBPeripheralManager*)peripheral central:(CBCentral*)central didSubscribeToCharacteristic:(CBCharacteristic*)characteristic {
}

- (void)peripheralManager:(CBPeripheralManager*)peripheral central:(CBCentral*)central didUnsubscribeFromCharacteristic:(CBCharacteristic*)characteristic {
}

- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager*)peripheral {
}

- (void)peripheralManager:(CBPeripheralManager*)peripheral didReceiveReadRequest:(CBATTRequest*)request {
}

- (void)peripheralManager:(CBPeripheralManager*)peripheral didReceiveWriteRequests:(NSArray*)requests {
}

@end
