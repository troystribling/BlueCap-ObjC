//
//  BlueCapPeripheralDefinition.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheralDefinition.h"
#import "BlueCapServiceDefinition+Private.h"
#import "CBUUID+StringValue.h"

@interface BlueCapPeripheralDefinition ()

@property(nonatomic, retain) NSString*              name;
@property(nonatomic, retain) NSMutableDictionary*   definedServices;

@end

@implementation BlueCapPeripheralDefinition

#pragma mark -
#pragma mark Service Definition

-(NSString*)name {
    return _name;
}

- (BlueCapServiceDefinition*)createServiceWithUUID:(NSString*)__uuidString andName:(NSString*)__name {
    return [self createServiceWithUUID:__uuidString name:__name andDefinition:nil];
}

- (BlueCapServiceDefinition*)createServiceWithUUID:(NSString*)__uuidString name:(NSString*)__name andDefinition:(BlueCapServiceDefinitionBlock)__definitionBlock {
    BlueCapServiceDefinition* serviceDefinition = [BlueCapServiceDefinition createWithUUID:__uuidString name:__name andDefinition:__definitionBlock];
    [self.definedServices setObject:serviceDefinition forKey:serviceDefinition.UUID];
    DLog(@"Service Defined: %@-%@", serviceDefinition.name, [serviceDefinition.UUID stringValue]);
    return serviceDefinition;
}

@end
