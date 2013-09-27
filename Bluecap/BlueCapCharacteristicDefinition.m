//
//  BlueCapCharacteristicDefinition.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristicDefinition.h"

@interface BlueCapCharacteristicDefinition ()

-(id)initWithUUID:(NSString*)__uuidString andName:(NSString*)__name;

@end

@implementation BlueCapCharacteristicDefinition

+ (BlueCapCharacteristicDefinition*)createWithUUID:(NSString*)__uuidString andName:(NSString*)__name {
    return [self createWithUUID:__uuidString name:__name andDefinition:nil];
}

+ (BlueCapCharacteristicDefinition*)createWithUUID:(NSString*)__uuidString name:(NSString*)__name andDefinition:(BlueCapCharacteristicDefinitionBlock)__definitionBlock {
    BlueCapCharacteristicDefinition* characteristicDefinition = [[self alloc] initWithUUID:__uuidString andName:__name];
    if (__definitionBlock) {
        __definitionBlock(characteristicDefinition);
    }
    return characteristicDefinition;
}

-(id)initWithUUID:(NSString*)__uuidString andName:(NSString*)__name {
    self = [super init];
    if (self) {
        self.name = __name;
        _UUID = [CBUUID UUIDWithString:__uuidString];
    }
    return self;
}

@end
