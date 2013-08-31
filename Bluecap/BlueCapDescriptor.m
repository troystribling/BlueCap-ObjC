//
//  BlueCapDescriptor.m
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapDescriptor.h"
#import "BlueCapCharacteristic.h"

@interface BlueCapDescriptor () {
    CBDescriptor*   cbDescriptor;
}

- (id)initWithCBDiscriptor:(CBDescriptor*)__descriptor andChracteristic:(BlueCapCharacteristic*)__chracteristic;

@end

@implementation BlueCapDescriptor

#pragma mark -
#pragma mark BlueCapCharacteristic

+ (BlueCapDescriptor*)withCBDiscriptor:(CBDescriptor*)__descriptor andChracteristic:(BlueCapCharacteristic*)__chracteristic {
    return [[BlueCapDescriptor alloc] initWithCBDiscriptor:__descriptor andChracteristic:__chracteristic];
}

- (id)initWithCBDiscriptor:(CBDescriptor*)__descriptor andChracteristic:(BlueCapCharacteristic*)__chracteristic {
    self = [super init];
    if (self) {
        _characteristic = __chracteristic;
        cbDescriptor = __descriptor;
    }
    return self;
}

-(id)value {
    return cbDescriptor.value;
}

-(CBUUID*)UUID {
    return cbDescriptor.UUID;
}

#pragma mark -
#pragma mark BlueCapCharacteristic PrivateAPI

@end
