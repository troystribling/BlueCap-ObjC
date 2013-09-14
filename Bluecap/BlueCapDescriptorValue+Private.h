//
//  BlueCapDescriptorValue+Private.h
//  BlueCap
//
//  Created by Troy Stribling on 9/12/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapDescriptorValue.h"

@class BlueCapDescriptor;

@interface BlueCapDescriptorValue (Private)

@property(nonatomic, retain) BlueCapDescriptor* bcDescriptor;

+ (BlueCapDescriptorValue*)withDescriptor:(BlueCapDescriptor*)__bcDescriptor;
- (id)initWithDescriptor:(BlueCapDescriptor*)__bcDescriptor;

@end
