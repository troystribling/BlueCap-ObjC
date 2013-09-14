//
//  BlueCapDescriptorValue.m
//  BlueCap
//
//  Created by Troy Stribling on 9/11/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapDescriptor+Private.h"
#import "BlueCapDescriptorValue.h"
#import "CBUUID+StringValue.h"

@interface BlueCapDescriptorValue ()

    @property(nonatomic, retain) BlueCapDescriptor* bcDescriptor;

@end

@implementation BlueCapDescriptorValue

- (NSString*)stringValue {
    NSString* uuidString = self.descriptor.UUID.stringValue;
    NSString* result = @"Unkown";
    if([uuidString isEqualToString:CBUUIDCharacteristicExtendedPropertiesString]  ||
       [uuidString isEqualToString:CBUUIDClientCharacteristicConfigurationString] ||
       [uuidString isEqualToString:CBUUIDServerCharacteristicConfigurationString]) {
        result = [self.bcDescriptor.cbDescriptor.value stringValue];
    } else if ([uuidString isEqualToString:CBUUIDCharacteristicUserDescriptionString]) {
        result = self.bcDescriptor.cbDescriptor.value;
    } else if ([uuidString isEqualToString:CBUUIDCharacteristicFormatString] ||
               [uuidString isEqualToString:CBUUIDCharacteristicAggregateFormatString]) {
        result = [[NSString alloc] initWithData:self.bcDescriptor.cbDescriptor.value encoding:NSUTF8StringEncoding];
    }
    return result;
}

- (BlueCapDescriptor*)descriptor {
    return self.bcDescriptor;
}

@end
