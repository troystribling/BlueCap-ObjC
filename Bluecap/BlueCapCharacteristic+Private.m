//
//  BlueCapCharacteristic+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCentralManager+Private.h"
#import "BlueCapCharacteristic+Private.h"
#import "BlueCapCharacteristicData+Private.h"
#import "BlueCapDescriptor+Private.h"

@implementation BlueCapCharacteristic (Private)

@dynamic cbCharacteristic;
@dynamic discoveredDiscriptors;
@dynamic service;
@dynamic onWriteCallback;
@dynamic onReadCallback;
@dynamic onDiscriptorDiscoveredCallback;

+ (BlueCapCharacteristic*)withCBCharacteristic:(CBCharacteristic*)__cbCharacteristics  andService:(BlueCapService*)__service {
    return [[BlueCapCharacteristic alloc] initWithCBCharacteristic:__cbCharacteristics andService:__service];
}

- (id)initWithCBCharacteristic:(CBCharacteristic*)__cbCharacteristic andService:(BlueCapService*)__service {
    self = [super init];
    if (self) {
        self.cbCharacteristic = __cbCharacteristic;
        self.service = __service;
        self.discoveredDiscriptors = [NSMutableArray array];
    }
    return self;
}

- (void)didUpdateValue:(NSError*)error {
    if (self.onReadCallback != nil) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.onReadCallback([BlueCapCharacteristicData withCharacteristic:self], error);
            self.onReadCallback = nil;
        }];
    }
}

- (void)didUpdateNotificationState:(NSError*)error {
}

- (void)didWriteValue:(NSError*)error{
    if (self.onWriteCallback != nil) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.onWriteCallback([BlueCapCharacteristicData withCharacteristic:self], error);
            self.onWriteCallback = nil;
        }];
    }
}

- (void)didDiscoverDescriptors:(NSArray*)__descriptors {
    if (self.onDiscriptorDiscoveredCallback) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.onDiscriptorDiscoveredCallback(__descriptors);
            self.onDiscriptorDiscoveredCallback = nil;
        }];
    }
}

@end
