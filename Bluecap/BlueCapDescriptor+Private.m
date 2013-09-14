//
//  BlueCapDescriptor+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 8/31/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapDescriptor+Private.h"
#import "BlueCapDescriptorValue+Private.h"

@implementation BlueCapDescriptor (Private)

@dynamic cbDescriptor;
@dynamic characteristic;
@dynamic onWrite;
@dynamic onRead;

+ (BlueCapDescriptor*)withCBDiscriptor:(CBDescriptor*)__descriptor andChracteristic:(BlueCapCharacteristic*)__chracteristic {
    return [[BlueCapDescriptor alloc] initWithCBDiscriptor:__descriptor andChracteristic:__chracteristic];
}

- (id)initWithCBDiscriptor:(CBDescriptor*)__descriptor andChracteristic:(BlueCapCharacteristic*)__chracteristic {
    self = [super init];
    if (self) {
        self.cbDescriptor = __descriptor;
        self.characteristic = __chracteristic;
    }
    return self;
}

- (void)didUpdateValue:(NSError*)error {
    if (self.onRead != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.onRead([BlueCapDescriptorValue withDescriptor:self], error);
        });
    }
}

- (void)didWriteValue:(NSError*)error{
    if (self.onWrite != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.onWrite([BlueCapDescriptorValue withDescriptor:self], error);
        });
    }
}

@end
