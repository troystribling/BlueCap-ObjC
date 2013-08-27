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

-(id)value {
    return cbDescriptor.value;
}

-(CBUUID*)UUID {
    return cbDescriptor.UUID;
}

#pragma mark -
#pragma mark BlueCapCharacteristic PrivateAPI

@end
