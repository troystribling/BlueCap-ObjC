//
//  BlueCapDescriptor.m
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapDescriptor.h"
#import "BlueCapCharacteristic.h"

@interface BlueCapDescriptor ()

@property(nonatomic, retain) CBDescriptor*          cbDescriptor;
@property(nonatomic, retain) BlueCapCharacteristic* characteristic;

@end

@implementation BlueCapDescriptor

#pragma mark -
#pragma mark BlueCapCharacteristic

-(id)value {
    return _cbDescriptor.value;
}

-(CBUUID*)UUID {
    return _cbDescriptor.UUID;
}

- (BlueCapCharacteristic*)characteristic {
    return _characteristic;
}

#pragma mark -
#pragma mark BlueCapCharacteristic PrivateAPI

@end
