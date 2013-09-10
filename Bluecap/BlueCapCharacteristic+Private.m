//
//  BlueCapCharacteristic+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristic+Private.h"
#import "BlueCapDescriptor+Private.h"

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
        self.discoveredDiscriptors = [NSMutableArray array];
    }
    return self;
}

- (void)didUpdateValue:(NSError*)error {
    if (self.onWrite != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.onWrite(error);
        });
    }
}

- (void)didUpdateNotificationState:(NSError*)error {
    if (self.onWrite != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.onWrite(error);
        });
    }
}

- (void)didWriteValue:(NSError*)error{
    if (self.onRead != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.onRead(error);
        });
    }
}

- (BlueCapDescriptor*)descriptorFor:(CBDescriptor*)__cbDescriptor {
    BlueCapDescriptor* selectedDescriptor = nil;
    for (BlueCapDescriptor* descriptor in self.discoveredDiscriptors) {
        if ([descriptor.cbDescriptor isEqual:__cbDescriptor]) {
            selectedDescriptor = descriptor;
            break;
        }
    }
    return selectedDescriptor;
}

@end
