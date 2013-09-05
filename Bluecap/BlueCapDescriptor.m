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

- (NSString*)stringValue {
    NSString* uuidString = self.UUID.stringValue;
    NSString* result = @"Unkown";
    if([uuidString isEqualToString:CBUUIDCharacteristicExtendedPropertiesString]  ||
       [uuidString isEqualToString:CBUUIDClientCharacteristicConfigurationString] ||
       [uuidString isEqualToString:CBUUIDServerCharacteristicConfigurationString]) {
        result = [self.cbDescriptor.value stringValue];
    } else if ([uuidString isEqualToString:CBUUIDCharacteristicUserDescriptionString]) {
        result = self.cbDescriptor.value;
    } else if ([uuidString isEqualToString:CBUUIDCharacteristicFormatString] ||
               [uuidString isEqualToString:CBUUIDCharacteristicAggregateFormatString]) {
        result = [[NSString alloc] initWithData:self.cbDescriptor.value encoding:NSUTF8StringEncoding];
    }
    return result;
}

#pragma mark -
#pragma mark BlueCapCharacteristic PrivateAPI

@end
