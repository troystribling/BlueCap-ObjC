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
#import "BlueCapPeripheral+Friend.h"
#import "BlueCapService+Friend.h"
#import "BlueCapCharacteristic+Friend.h"
#import "BlueCapCentralManager+Friend.h"
#import "CBUUID+StringValue.h"

@interface BlueCapDescriptor ()

@property(nonatomic, retain) CBDescriptor*                  cbDescriptor;
@property(nonatomic, retain) BlueCapCharacteristic*         characteristic;
@property(nonatomic, copy) BlueCapDescriptorDataCallback    onReadCallback;
@property(nonatomic, copy) BlueCapDescriptorDataCallback    onWriteCallback;

@end

@implementation BlueCapDescriptor

#pragma mark - BlueCapCharacteristic

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

- (NSString*)stringValue {
    NSString* uuidString = self.UUID.stringValue;
    __block NSString* result = @"Unkown";
    [[BlueCapCentralManager sharedInstance] syncMain:^{
        // value is NSNumber
        if([uuidString isEqualToString:CBUUIDCharacteristicExtendedPropertiesString]  ||
           [uuidString isEqualToString:CBUUIDClientCharacteristicConfigurationString] ||
           [uuidString isEqualToString:CBUUIDServerCharacteristicConfigurationString]) {
            result = [self.cbDescriptor.value stringValue];
            // value is NSString
        } else if ([uuidString isEqualToString:CBUUIDCharacteristicUserDescriptionString]) {
            result = self.cbDescriptor.value;
            // value is NSData
        } else if ([uuidString isEqualToString:CBUUIDCharacteristicFormatString] ||
                   [uuidString isEqualToString:CBUUIDCharacteristicAggregateFormatString]) {
            result = [[NSString alloc] initWithData:self.cbDescriptor.value encoding:NSUTF8StringEncoding];
        }
    }];
    return result;
}

- (NSNumber*)numberValue {
    NSString* uuidString = self.UUID.stringValue;
    __block NSNumber* result = [NSNumber numberWithInt:-1];
    [[BlueCapCentralManager sharedInstance] syncMain:^{
        // value is NSNumber
        if([uuidString isEqualToString:CBUUIDCharacteristicExtendedPropertiesString]  ||
           [uuidString isEqualToString:CBUUIDClientCharacteristicConfigurationString] ||
           [uuidString isEqualToString:CBUUIDServerCharacteristicConfigurationString]) {
            result = self.cbDescriptor.value;
            // value is NSString
        } else if ([uuidString isEqualToString:CBUUIDCharacteristicUserDescriptionString]) {
            result = [[NSNumberFormatter alloc] numberFromString:self.cbDescriptor.value];
            // value is NSData
        } else if ([uuidString isEqualToString:CBUUIDCharacteristicFormatString] ||
                   [uuidString isEqualToString:CBUUIDCharacteristicAggregateFormatString]) {
            [NSException raise:@"Invalid Descriptor value format" format:@"value with format NSData cannot be converted to NSNumber"];
        }
    }];
    return result;
}

- (NSData*)dataValue {
    NSString* uuidString = self.UUID.stringValue;
    __block NSData* result = [NSData data];
    [[BlueCapCentralManager sharedInstance] syncMain:^{
        // value is NSNumber
        if([uuidString isEqualToString:CBUUIDCharacteristicExtendedPropertiesString]  ||
           [uuidString isEqualToString:CBUUIDClientCharacteristicConfigurationString] ||
           [uuidString isEqualToString:CBUUIDServerCharacteristicConfigurationString]) {
            result = [NSKeyedArchiver archivedDataWithRootObject:self.cbDescriptor.value];
            // value is NSString
        } else if ([uuidString isEqualToString:CBUUIDCharacteristicUserDescriptionString]) {
            result = [self.cbDescriptor.value dataUsingEncoding:NSUTF8StringEncoding];
            // value is NSData
        } else if ([uuidString isEqualToString:CBUUIDCharacteristicFormatString] ||
                   [uuidString isEqualToString:CBUUIDCharacteristicAggregateFormatString]) {
            result = self.cbDescriptor.value;
        }
    }];
    return result;
}

#pragma mark - I/O

- (void)read:(BlueCapDescriptorDataCallback)__onReadCallback {
    self.onReadCallback = __onReadCallback;
    [self.characteristic.service.peripheral.cbPeripheral readValueForDescriptor:self.cbDescriptor];
}

- (void)writeData:(NSData*)data onWrite:(BlueCapDescriptorDataCallback)__onWriteCallback {
    self.onWriteCallback = __onWriteCallback;
    [self.characteristic.service.peripheral.cbPeripheral writeValue:data forDescriptor:self.cbDescriptor];
}

#pragma mark - BlueCapCharacteristic PrivateAPI

@end
