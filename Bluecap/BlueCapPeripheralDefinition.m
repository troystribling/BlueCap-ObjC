//
//  BlueCapPeripheralDefinition.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheralDefinition.h"

@interface BlueCapPeripheralDefinition ()

-(id)initWithUUID:(NSString*)__uuidString image:(UIImage*)__image andDefinition:(BlueCapPeripheralDefinitionBlock)__definitionBlock;

@end

@implementation BlueCapPeripheralDefinition

+ (void)createWithUUID:(NSString*)__uuidString andDefinition:(BlueCapPeripheralDefinitionBlock)__definitionBlock {
}

+ (void)createWithUUID:(NSString*)__uuidString image:(UIImage*)__image andDefinition:(BlueCapPeripheralDefinitionBlock)__definitionBlock {
}

-(id)initWithUUID:(NSString*)__uuidString image:(UIImage*)__image andDefinition:(BlueCapPeripheralDefinitionBlock)__definitionBlock {
    self = [super init];
    if (self) {
    }
    return self;
}

@end
