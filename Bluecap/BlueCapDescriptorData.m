//
//  BlueCapDescriptorValue.m
//  BlueCap
//
//  Created by Troy Stribling on 9/11/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCentralManager+Private.h"
#import "BlueCapDescriptorData+Private.h"
#import "BlueCapDescriptor+Private.h"
#import "CBUUID+StringValue.h"

@interface BlueCapDescriptorData ()
    @property(nonatomic, retain) BlueCapDescriptor* bcDescriptor;
@end

@implementation BlueCapDescriptorData

- (NSString*)stringValue {
    NSString* uuidString = self.descriptor.UUID.stringValue;
    __block NSString* result = @"Unkown";
    [[BlueCapCentralManager sharedInstance] sync:^{
        // value is NSNumber
        if([uuidString isEqualToString:CBUUIDCharacteristicExtendedPropertiesString]  ||
           [uuidString isEqualToString:CBUUIDClientCharacteristicConfigurationString] ||
           [uuidString isEqualToString:CBUUIDServerCharacteristicConfigurationString]) {
            result = [self.bcDescriptor.cbDescriptor.value stringValue];
        // value is NSString
        } else if ([uuidString isEqualToString:CBUUIDCharacteristicUserDescriptionString]) {
            result = self.bcDescriptor.cbDescriptor.value;
        // value is NSData
        } else if ([uuidString isEqualToString:CBUUIDCharacteristicFormatString] ||
                   [uuidString isEqualToString:CBUUIDCharacteristicAggregateFormatString]) {
            result = [[NSString alloc] initWithData:self.bcDescriptor.cbDescriptor.value encoding:NSUTF8StringEncoding];
        }
    }];
    return result;
}

- (BlueCapDescriptor*)descriptor {
    return self.bcDescriptor;
}

- (NSNumber*)numberValue {
    NSString* uuidString = self.descriptor.UUID.stringValue;
    __block NSNumber* result = [NSNumber numberWithInt:-1];
    [[BlueCapCentralManager sharedInstance] sync:^{
        // value is NSNumber
        if([uuidString isEqualToString:CBUUIDCharacteristicExtendedPropertiesString]  ||
           [uuidString isEqualToString:CBUUIDClientCharacteristicConfigurationString] ||
           [uuidString isEqualToString:CBUUIDServerCharacteristicConfigurationString]) {
            result = self.bcDescriptor.cbDescriptor.value;
        // value is NSString
        } else if ([uuidString isEqualToString:CBUUIDCharacteristicUserDescriptionString]) {
            result = [[NSNumberFormatter alloc] numberFromString:self.bcDescriptor.cbDescriptor.value];
        // value is NSData
        } else if ([uuidString isEqualToString:CBUUIDCharacteristicFormatString] ||
                   [uuidString isEqualToString:CBUUIDCharacteristicAggregateFormatString]) {
            [NSException raise:@"Invalid Descriptor value format" format:@"value with format NSData cannot be converted to NSNumber"];
        }
    }];
    return result;
}

- (NSData*)dataValue {
    NSString* uuidString = self.descriptor.UUID.stringValue;
    __block NSData* result = [NSData data];
    [[BlueCapCentralManager sharedInstance] sync:^{
        // value is NSNumber
        if([uuidString isEqualToString:CBUUIDCharacteristicExtendedPropertiesString]  ||
           [uuidString isEqualToString:CBUUIDClientCharacteristicConfigurationString] ||
           [uuidString isEqualToString:CBUUIDServerCharacteristicConfigurationString]) {
            result = [NSKeyedArchiver archivedDataWithRootObject:self.bcDescriptor.cbDescriptor.value];
        // value is NSString
        } else if ([uuidString isEqualToString:CBUUIDCharacteristicUserDescriptionString]) {
            result = [self.bcDescriptor.cbDescriptor.value dataUsingEncoding:NSUTF8StringEncoding];
        // value is NSData
        } else if ([uuidString isEqualToString:CBUUIDCharacteristicFormatString] ||
                   [uuidString isEqualToString:CBUUIDCharacteristicAggregateFormatString]) {
            result = self.bcDescriptor.cbDescriptor.value;
        }
    }];
    return result;
}

@end
