//
//  BlueCapServiceDefinition.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapServiceDefinition.h"

@interface BlueCapServiceDefinition ()

- (id)initWithUUID:(NSString*)__uuidString image:(UIImage*)__image;

@end

@implementation BlueCapServiceDefinition

+ (BlueCapServiceDefinition*)createWithUUID:(NSString*)__uuidString {
    return [self createWithUUID:__uuidString image:nil andDefinition:nil];
}

+ (BlueCapServiceDefinition*)createWithUUID:(NSString*)__uuidString image:(UIImage*)__image {
    return [self createWithUUID:__uuidString image:__image andDefinition:nil];
}

+ (BlueCapServiceDefinition*)createWithUUID:(NSString*)__uuidString andDefinition:(BlueCapServiceDefinitionBlock)__definitionBlock {
    return [self createWithUUID:__uuidString image:nil andDefinition:__definitionBlock];
}

+ (BlueCapServiceDefinition*)createWithUUID:(NSString*)__uuidString image:(UIImage*)__image andDefinition:(BlueCapServiceDefinitionBlock)__definitionBlock {
    BlueCapServiceDefinition* serviceDefinition = [[self alloc] initWithUUID:__uuidString image:__image];
    if (__definitionBlock) {
        __definitionBlock(serviceDefinition);
    }
    return serviceDefinition;
}

-(id)initWithUUID:(NSString*)__uuidString image:(UIImage*)__image {
    self = [super init];
    if (self) {
    }
    return self;
}

@end
