//
//  BlueCapCharacteristicDefinition+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 9/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristicDefinition+Private.h"

@implementation BlueCapCharacteristicDefinition (Private)

@dynamic UUID;
@dynamic name;

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
        self.UUID = [CBUUID UUIDWithString:__uuidString];
    }
    return self;
}
@end
