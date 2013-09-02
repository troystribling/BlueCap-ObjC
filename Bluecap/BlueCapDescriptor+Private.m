//
//  BlueCapDescriptor+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 8/31/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapDescriptor+Private.h"

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
}

- (void)didWriteValue:(NSError*)error{
}

@end
