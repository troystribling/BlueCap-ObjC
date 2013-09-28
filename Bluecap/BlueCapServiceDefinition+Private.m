//
//  BlueCapServiceDefinition+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 9/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapServiceDefinition+Private.h"

@implementation BlueCapServiceDefinition (Private)

@dynamic UUID;
@dynamic name;
@dynamic definedCharacteristics;
@dynamic definition;

+ (BlueCapServiceDefinition*)createWithUUID:(NSString*)__uuidString name:(NSString*)__name andDefinition:(BlueCapServiceDefinitionBlock)__definitionBlock {
    BlueCapServiceDefinition* serviceDefinition = [[self alloc] initWithUUID:__uuidString andName:__name];
    if (__definitionBlock) {
        __definitionBlock(serviceDefinition);
    }
    return serviceDefinition;
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
