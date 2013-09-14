//
//  BlueCapDescriptorValue+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 9/12/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapDescriptorValue+Private.h"

@implementation BlueCapDescriptorValue (Private)

@dynamic bcDescriptor;

+ (BlueCapDescriptorValue*)withDescriptor:(BlueCapDescriptor*)__bcDescriptor {
    return [[BlueCapDescriptorValue alloc] initWithDescriptor:__bcDescriptor];
}

- (id)initWithDescriptor:(BlueCapDescriptor*)__bcDescriptor {
    self = [super init];
    if (self) {
        self.bcDescriptor = __bcDescriptor;
    }
    return self;
}

@end
