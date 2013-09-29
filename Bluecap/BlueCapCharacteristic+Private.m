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
#import "BlueCapService+Private.h"

@implementation BlueCapCharacteristic (Private)

@dynamic cbCharacteristic;
@dynamic discoveredDiscriptors;
@dynamic service;
@dynamic onWriteCallback;
@dynamic onReadCallback;
@dynamic onDescriptorsDiscoveredCallback;
@dynamic definition;

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
        }];
    }
}

- (void)didUpdateNotificationState:(NSError*)error {
}

- (void)didWriteValue:(NSError*)error{
    if (self.onWriteCallback != nil) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.onWriteCallback([BlueCapCharacteristicData withCharacteristic:self], error);
        }];
    }
}

- (void)didDiscoverDescriptors:(NSArray*)__descriptors {
    if (self.onDescriptorsDiscoveredCallback) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.onDescriptorsDiscoveredCallback(__descriptors);
        }];
    }
}

@end
