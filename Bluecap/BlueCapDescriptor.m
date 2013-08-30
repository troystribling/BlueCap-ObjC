//
//  BlueCapDescriptor.m
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapDescriptor.h"

@interface BlueCapDescriptor ()

@property(nonatomic, retain) CBDescriptor*   cbDescriptor;

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
        self.cbDescriptor = __descriptor;
    }
    return self;
}

-(id)value {
    return self.cbDescriptor.value;
}

-(CBUUID*)UUID {
    return self.cbDescriptor.UUID;
}

#pragma mark -
#pragma mark BlueCapCharacteristic PrivateAPI

@end
