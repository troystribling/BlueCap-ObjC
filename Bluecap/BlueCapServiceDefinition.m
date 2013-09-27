//
//  BlueCapServiceDefinition.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapServiceDefinition.h"

@interface BlueCapServiceDefinition ()

- (id)initWithUUID:(NSString*)__uuidString andName:(NSString*)__name;

@end

@implementation BlueCapServiceDefinition

+ (BlueCapServiceDefinition*)createWithUUID:(NSString*)__uuidString andName:(NSString*)__name {
    return [self createWithUUID:__uuidString name:__name andDefinition:nil];
}

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
        _UUID = [CBUUID UUIDWithString:__uuidString];
    }
    return self;
}

@end
