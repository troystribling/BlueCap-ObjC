//
//  BlueCapCharacteristic+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristic+Private.h"
#import "BlueCapCharacteristicData+Private.h"
#import "BlueCapDescriptor+Private.h"

@implementation BlueCapCharacteristic (Private)

@dynamic cbCharacteristic;
@dynamic discoveredDiscriptors;
@dynamic service;
@dynamic onWriteCallback;
@dynamic onReadCallback;

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
        dispatch_async(dispatch_get_main_queue(), ^{
            self.onReadCallback([BlueCapCharacteristicData withCharacteristic:self], error);
            self.onReadCallback = nil;
        });
    }
}

- (void)didUpdateNotificationState:(NSError*)error {
}

- (void)didWriteValue:(NSError*)error{
    if (self.onWriteCallback != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.onWriteCallback([BlueCapCharacteristicData withCharacteristic:self], error);
            self.onWriteCallback = nil;
        });
    }
}

@end
