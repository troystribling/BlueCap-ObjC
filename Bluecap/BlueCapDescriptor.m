//
//  BlueCapDescriptor.m
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapDescriptor.h"

@interface BlueCapDescriptor () {
    CBDescriptor*   cbDescriptor;
}
@end

@implementation BlueCapDescriptor

#pragma mark -
#pragma mark BlueCapCharacteristic

+ (BlueCapDescriptor*)withCBDiscriptor:(CBDescriptor*)__descriptor {
    return [[BlueCapDescriptor alloc] initWithCBDiscriptor:__descriptor];
}

- (id)initWithCBDiscriptor:(CBDescriptor*)__descriptor {
    self = [super init];
    if (self) {
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
