//
//  BlueCapDescriptor+Friend.m
//  BlueCap
//
//  Created by Troy Stribling on 8/31/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapDescriptor+Friend.h"
#import "BlueCapCentralManager+Friend.h"

@implementation BlueCapDescriptor (Friend)

@dynamic cbDescriptor;
@dynamic characteristic;
@dynamic afterWriteCallback;
@dynamic afterReadCallback;

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
    ASYNC_CALLBACK(self.afterReadCallback, self.afterReadCallback(self, error))
}

- (void)didWriteValue:(NSError*)error{
    ASYNC_CALLBACK(self.afterWriteCallback, self.afterWriteCallback(self, error))
}

@end
