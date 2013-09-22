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
#import "CBUUID+StringValue.h"

@interface BlueCapDescriptor ()

@property(nonatomic, retain) CBDescriptor*              cbDescriptor;
@property(nonatomic, retain) BlueCapCharacteristic*     characteristic;
@property(nonatomic, copy) BlueCapDescriptorCallback    onReadCallback;
@property(nonatomic, copy) BlueCapDescriptorCallback    onWriteCallback;

@end

@implementation BlueCapDescriptor

#pragma mark -
#pragma mark BlueCapCharacteristic

- (CBUUID*)UUID {
    return _cbDescriptor.UUID;
}

- (BlueCapCharacteristic*)characteristic {
    return _characteristic;
}

- (NSString*)typeStringValue {
    NSString* uuidString = self.UUID.stringValue;
    NSString* result = @"Unkown";
    if([uuidString isEqualToString:CBUUIDCharacteristicExtendedPropertiesString]) {
        result = @"Extended Property";
    } else if ([uuidString isEqualToString:CBUUIDCharacteristicUserDescriptionString]) {
        result = @"User Description";
    } else if ([uuidString isEqualToString:CBUUIDClientCharacteristicConfigurationString]) {
        result = @"Client Configuration";
    } else if ([uuidString isEqualToString:CBUUIDServerCharacteristicConfigurationString]) {
        result = @"Server Configuration";
    } else if ([uuidString isEqualToString:CBUUIDCharacteristicFormatString]) {
        result = @"Format";
    } else if ([uuidString isEqualToString:CBUUIDCharacteristicAggregateFormatString]) {
        result = @"Aggregate Format";
    }
    return result;
}

#pragma mark -
#pragma mark I/O

- (void)read:(BlueCapDescriptorCallback)__onReadCallback {
    self.onReadCallback = __onReadCallback;
    [self.characteristic.service.peripheral.cbPeripheral readValueForDescriptor:self.cbDescriptor];
}

- (void)write:(NSData*)data onWrite:(BlueCapDescriptorCallback)__onWriteCallback {
    self.onWriteCallback = __onWriteCallback;
    [self.characteristic.service.peripheral.cbPeripheral writeValue:data forDescriptor:self.cbDescriptor];
}

#pragma mark -
#pragma mark BlueCapCharacteristic PrivateAPI

@end
