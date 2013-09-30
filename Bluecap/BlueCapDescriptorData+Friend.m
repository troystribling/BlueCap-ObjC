//
//  BlueCapDescriptorData+Friend.m
//  BlueCap
//
//  Created by Troy Stribling on 9/12/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapDescriptorData+Friend.h"

@implementation BlueCapDescriptorData (Friend)

@dynamic bcDescriptor;

+ (BlueCapDescriptorData*)withDescriptor:(BlueCapDescriptor*)__bcDescriptor {
    return [[BlueCapDescriptorData alloc] initWithDescriptor:__bcDescriptor];
}

- (id)initWithDescriptor:(BlueCapDescriptor*)__descriptor {
    self = [super init];
    if (self) {
        self.bcDescriptor = __descriptor;
    }
    return self;
}

@end
