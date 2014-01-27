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
@dynamic updateSequenceNumber;

+ (BlueCapCharacteristic*)withCBCharacteristic:(CBCharacteristic*)__cbCharacteristics  andService:(BlueCapService*)__service {
    return [[BlueCapCharacteristic alloc] initWithCBCharacteristic:__cbCharacteristics andService:__service];
}

- (id)initWithCBCharacteristic:(CBCharacteristic*)__cbCharacteristic andService:(BlueCapService*)__service {
    self = [super init];
    if (self) {
        self.cbCharacteristic = __cbCharacteristic;
        self.service = __service;
        self.discoveredDiscriptors = [NSMutableArray array];
        self.updateSequenceNumber = 0;
    }
    return self;
}

- (void)didUpdateValue:(NSError*)error {
    if (self.afterReadCallback != nil) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.afterReadCallback(self, error);
        }];
    }
}

- (void)didUpdateNotificationState:(NSError*)error {
    if (self.notificationStateDidChangeCallback) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.notificationStateDidChangeCallback();
        }];
    }
}

- (void)didWriteValue:(NSError*)error{
    if (self.afterWriteCallback != nil) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.afterWriteCallback(self, error);
        }];
    }
}

- (void)didDiscoverDescriptors:(NSArray*)__descriptors {
    if (self.afterDescriptorsDiscoveredCallback) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.afterDescriptorsDiscoveredCallback(__descriptors);
        }];
    }
}

@end
