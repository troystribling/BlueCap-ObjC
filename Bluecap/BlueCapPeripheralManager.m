//
//  BlueCapPeripheralManager.m
//  BlueCap
//
//  Created by Troy Stribling on 11/3/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheralManager.h"

static BlueCapPeripheralManager* thisBlueCapPeripheralManager = nil;

@interface BlueCapPeripheralManager()

@property(nonatomic, retain) CBPeripheralManager*                       cbPeripheralManager;
@property(nonatomic, retain) dispatch_queue_t                           mainQueue;
@property(nonatomic, retain) dispatch_queue_t                           callbackQueue;
@property(nonatomic, copy) BlueCapPeripheralManagerStartedAdvertising   startedAdvertisingCallback;
@property(nonatomic, copy) BlueCapPeripheralManagerStoppedAdvertising   stoppedAdvertisingCallback;

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
    }
    return self;
}

- (BOOL)isAdvertising {
    return self.cbPeripheralManager.isAdvertising;
}

- (CBPeripheralManagerState)state {
    return self.cbPeripheralManager.state;
}

- (void)startAdvertising:(BlueCapPeripheralManagerStartedAdvertising)__startedAdvertisingCallback {
    self.startedAdvertisingCallback = __startedAdvertisingCallback;
    [self.cbPeripheralManager startAdvertising:@{CBAdvertisementDataLocalNameKey:@"Test",
                                                 CBAdvertisementDataServiceUUIDsKey:@"abc"}];
}

- (void)stopAdvertising:(BlueCapPeripheralManagerStoppedAdvertising)__stoppedAdvertisingCallback {
    self.stoppedAdvertisingCallback = __stoppedAdvertisingCallback;
    [self.cbPeripheralManager stopAdvertising];
}

#pragma mark - BlueCapPeripheralManagerDelegate

- (void)peripheralManager:(CBPeripheralManager*)peripheral willRestoreState:(NSDictionary*)dict {
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager*)peripheral {
}

- (void)peripheralManager:(CBPeripheralManager*)peripheral didAddService:(CBService*)service error:(NSError*)error {
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager*)peripheral error:(NSError*)error {
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
