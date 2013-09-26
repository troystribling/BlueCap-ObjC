//
//  BlueCapChracteristicDefinition.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapChracteristicDefinition.h"

@interface BlueCapChracteristicDefinition ()

-(id)initWithUUID:(NSString*)__uuidString;

@end

@implementation BlueCapChracteristicDefinition

+ (BlueCapChracteristicDefinition*)createWithUUID:(NSString*)__uuidString {
    return [self createWithUUID:__uuidString andDefinition:nil];
}

+ (BlueCapChracteristicDefinition*)createWithUUID:(NSString*)__uuidString andDefinition:(BlueCapCharacteristicDefinitionBlock)__definitionBlock {
    BlueCapChracteristicDefinition* characteristicDefinition = [[self alloc] initWithUUID:__uuidString];
    if (__definitionBlock) {
        __definitionBlock(characteristicDefinition);
    }
    return characteristicDefinition;
}

-(id)initWithUUID:(NSString*)__uuidString {
    self = [super init];
    if (self) {
    }
    return self;
}

@end
