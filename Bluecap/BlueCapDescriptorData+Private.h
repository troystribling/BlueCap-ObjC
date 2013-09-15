//
//  BlueCapDescriptorData+Private.h
//  BlueCap
//
//  Created by Troy Stribling on 9/12/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapDescriptorData.h"

@class BlueCapDescriptor;

@interface BlueCapDescriptorData (Private)

@property(nonatomic, retain) BlueCapDescriptor* bcDescriptor;

+ (BlueCapDescriptorData*)withDescriptor:(BlueCapDescriptor*)__bcDescriptor;
- (id)initWithDescriptor:(BlueCapDescriptor*)__bcDescriptor;

@end
