//
//  BlueCapPeripheralDefinition.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheralDefinition.h"

@interface BlueCapPeripheralDefinition ()

-(id)initWithUUID:(NSString*)__uuidString image:(UIImage*)__image;

@end

@implementation BlueCapPeripheralDefinition

+ (BlueCapPeripheralDefinition*)createWithUUID:(NSString*)__uuidString {
    return [self createWithUUID:__uuidString image:nil andDefinition:nil];
}

+ (BlueCapPeripheralDefinition*)createWithUUID:(NSString*)__uuidString image:(UIImage*)__image {
    return [self createWithUUID:__uuidString image:__image andDefinition:nil];
}

+ (BlueCapPeripheralDefinition*)createWithUUID:(NSString*)__uuidString andDefinition:(BlueCapPeripheralDefinitionBlock)__definitionBlock {
    return [self createWithUUID:__uuidString image:nil andDefinition:__definitionBlock];
}

+ (BlueCapPeripheralDefinition*)createWithUUID:(NSString*)__uuidString image:(UIImage*)__image andDefinition:(BlueCapPeripheralDefinitionBlock)__definitionBlock {
    BlueCapPeripheralDefinition* peripheralDefinition = [[self alloc] initWithUUID:__uuidString image:__image];
    if (__definitionBlock) {
        __definitionBlock(peripheralDefinition);
    }
    return peripheralDefinition;
}

-(id)initWithUUID:(NSString*)__uuidString image:(UIImage*)__image {
    self = [super init];
    if (self) {
    }
    return self;
}

@end
