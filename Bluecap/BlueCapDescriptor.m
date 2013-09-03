//
//  BlueCapDescriptor.m
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapDescriptor.h"
#import "BlueCapPeripheral.h"
#import "BlueCapService.h"
#import "BlueCapCharacteristic.h"
#import "BlueCapPeripheral+Private.h"
#import "BlueCapService+Private.h"
#import "BlueCapCharacteristic+Private.h"

@interface BlueCapDescriptor ()

@property(nonatomic, retain) CBDescriptor*          cbDescriptor;
@property(nonatomic, retain) BlueCapCharacteristic* characteristic;
@property(nonatomic, copy) BlueCapCallback          onRead;
@property(nonatomic, copy) BlueCapCallback          onWrite;

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

- (void)read:(BlueCapCallback)__onRead {
    self.onRead = __onRead;
    [self.characteristic.service.peripheral.cbPeripheral readValueForDescriptor:self.cbDescriptor];
}

- (void)write:(NSData*)data onWrite:(BlueCapCallback)__onWrite {
    self.onWrite = __onWrite;
    [self.characteristic.service.peripheral.cbPeripheral writeValue:data forDescriptor:self.cbDescriptor];
}

#pragma mark -
#pragma mark BlueCapCharacteristic PrivateAPI

@end
