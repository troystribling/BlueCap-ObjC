//
//  BlueCapCharacteristic+Friend.m
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCentralManager+Friend.h"
#import "BlueCapCharacteristic+Friend.h"
#import "BlueCapDescriptor+Friend.h"
#import "BlueCapService+Friend.h"

@implementation BlueCapCharacteristic (Friend)

@dynamic cbCharacteristic;
@dynamic discoveredDiscriptors;
@dynamic service;
@dynamic profile;
@dynamic afterWriteCallback;
@dynamic afterReadCallback;
@dynamic afterDescriptorsDiscoveredCallback;
@dynamic notificationStateDidChangeCallback;
@dynamic timeoutSequenceNumber;
@dynamic updateReceived;
@dynamic writeReceived;

+ (BlueCapCharacteristic*)withCBCharacteristic:(CBCharacteristic*)__cbCharacteristics  andService:(BlueCapService*)__service {
    return [[BlueCapCharacteristic alloc] initWithCBCharacteristic:__cbCharacteristics andService:__service];
}

- (id)initWithCBCharacteristic:(CBCharacteristic*)__cbCharacteristic andService:(BlueCapService*)__service {
    self = [super init];
    if (self) {
        self.cbCharacteristic = __cbCharacteristic;
        self.service = __service;
        self.discoveredDiscriptors = [NSMutableArray array];
        self.timeoutSequenceNumber = 0;
        self.updateReceived = NO;
        self.writeReceived = NO;
    }
    return self;
}

- (void)didUpdateValue:(NSError*)error {
    self.updateReceived = YES;
    ASYNC_CALLBACK(self.afterReadCallback, self.afterReadCallback(self, error))
}

- (void)didUpdateNotificationState:(NSError*)error {
    ASYNC_CALLBACK(self.notificationStateDidChangeCallback, self.notificationStateDidChangeCallback())
}

- (void)didWriteValue:(NSError*)error{
    self.writeReceived = YES;
    ASYNC_CALLBACK(self.afterWriteCallback, self.afterWriteCallback(self, error))
}

- (void)didDiscoverDescriptors:(NSArray*)__descriptors {
    ASYNC_CALLBACK(self.afterDescriptorsDiscoveredCallback, self.afterDescriptorsDiscoveredCallback(__descriptors))
}

@end
