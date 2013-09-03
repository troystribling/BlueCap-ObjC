//
//  BlueCapCharacteristic+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristic+Private.h"

@implementation BlueCapCharacteristic (Private)

@dynamic cbCharacteristic;
@dynamic discoveredDiscriptors;
@dynamic service;
@dynamic onWrite;
@dynamic onRead;

+ (BlueCapCharacteristic*)withCBCharacteristic:(CBCharacteristic*)__cbCharacteristics  andService:(BlueCapService*)__service {
    return [[BlueCapCharacteristic alloc] initWithCBCharacteristic:__cbCharacteristics andService:__service];
}

- (id)initWithCBCharacteristic:(CBCharacteristic*)__cbCharacteristic andService:(BlueCapService*)__service {
    self = [super init];
    if (self) {
        self.cbCharacteristic = __cbCharacteristic;
        self.service = __service;
        self.discoveredDiscriptors = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)didUpdateValue:(NSError*)error {
    if (self.onWrite != nil) {
        self.onWrite(error);
    }
}

- (void)didUpdateNotificationState:(NSError*)error {
    if (self.onWrite != nil) {
        self.onWrite(error);
    }
}

- (void)didWriteValue:(NSError*)error{
    if (self.onRead != nil) {
        self.onRead(error);
    }
}

@end
