//
//  BlueCapChracteristicDefinition.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapChracteristicDefinition.h"

@interface BlueCapChracteristicDefinition ()

-(id)initWithUUID:(NSString*)__uuidString image:(UIImage*)__image;

@end

@implementation BlueCapChracteristicDefinition

+ (BlueCapChracteristicDefinition*)createWithUUID:(NSString*)__uuidString {
    return [self createWithUUID:__uuidString image:nil andDefinition:nil];
}

+ (BlueCapChracteristicDefinition*)createWithUUID:(NSString*)__uuidString image:(UIImage*)__image {
    return [self createWithUUID:__uuidString image:__image andDefinition:nil];
}

+ (BlueCapChracteristicDefinition*)createWithUUID:(NSString*)__uuidString andDefinition:(BlueCapCharacteristicDefinitionBlock)__definitionBlock {
    return [self createWithUUID:__uuidString image:nil andDefinition:__definitionBlock];
}

+ (BlueCapChracteristicDefinition*)createWithUUID:(NSString*)__uuidString image:(UIImage*)__image andDefinition:(BlueCapCharacteristicDefinitionBlock)__definitionBlock {
    BlueCapChracteristicDefinition* characteristicDefinition = [[self alloc] initWithUUID:__uuidString image:__image];
    if (__definitionBlock) {
        __definitionBlock(characteristicDefinition);
    }
    return characteristicDefinition;
}

-(id)initWithUUID:(NSString*)__uuidString image:(UIImage*)__image {
    self = [super init];
    if (self) {
    }
    return self;
}

@end
