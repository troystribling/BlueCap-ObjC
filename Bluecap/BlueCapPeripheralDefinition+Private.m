//
//  BlueCapPeripheralDefinition+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 9/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheralDefinition+Private.h"

@implementation BlueCapPeripheralDefinition (Private)

@dynamic identifier;

+ (BlueCapPeripheralDefinition*)createWithUUID:(NSString*)__uuidString {
    return [self createWithUUID:__uuidString andDefinition:nil];
}

+ (BlueCapPeripheralDefinition*)createWithUUID:(NSString*)__uuidString andDefinition:(BlueCapPeripheralDefinitionBlock)__definitionBlock {
    BlueCapPeripheralDefinition* peripheralDefinition = [[self alloc] initWithUUID:__uuidString];
    if (__definitionBlock) {
        __definitionBlock(peripheralDefinition);
    }
    return peripheralDefinition;
}

-(id)initWithUUID:(NSString*)__uuidString {
    self = [super init];
    if (self) {
        self.identifier = [[NSUUID alloc] initWithUUIDString:__uuidString];
    }
    return self;
}

@end
