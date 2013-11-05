//
//  BlueCapMutableDescriptor.m
//  BlueCap
//
//  Created by Troy Stribling on 11/4/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapMutableDescriptor.h"

@interface BlueCapMutableDescriptor ()

@property(nonatomic, retain) CBMutableDescriptor*   cbDescriptor;

@end

@implementation BlueCapMutableDescriptor

#pragma mark - BlueCapDescriptor

- (CBUUID*)UUID {
    return _cbDescriptor.UUID;
}

@end
