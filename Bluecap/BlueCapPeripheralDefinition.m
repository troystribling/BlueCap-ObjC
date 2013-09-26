//
//  BlueCapPeripheralDefinition.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheralDefinition.h"

@interface BlueCapPeripheralDefinition ()

-(id)initWithUUID:(NSString*)__uuidString;

@end

@implementation BlueCapPeripheralDefinition

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
    }
    return self;
}

@end
