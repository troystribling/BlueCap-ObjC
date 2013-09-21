//
//  BlueCapDescriptor+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 8/31/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapDescriptor+Private.h"
#import "BlueCapCentralManager+Private.h"
#import "BlueCapDescriptorData+Private.h"

@implementation BlueCapDescriptor (Private)

@dynamic cbDescriptor;
@dynamic characteristic;
@dynamic onWriteCallback;
@dynamic onReadCallback;

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
    if (self.onReadCallback != nil) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.onReadCallback([BlueCapDescriptorData withDescriptor:self], error);
            self.onReadCallback = nil;
        }];
    }
}

- (void)didWriteValue:(NSError*)error{
    if (self.onWriteCallback != nil) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.onWriteCallback([BlueCapDescriptorData withDescriptor:self], error);
            self.onWriteCallback = nil;
        }];
    }
}

@end
