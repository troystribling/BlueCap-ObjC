//
//  BlueCapPeripheralDefinition+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 9/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheralDefinition+Private.h"

@implementation BlueCapPeripheralDefinition (Private)

@dynamic name;
@dynamic definedServices;

+ (BlueCapPeripheralDefinition*)createWithName:(NSString*)__name andDefinition:(BlueCapPeripheralDefinitionBlock)__definitionBlock {
    BlueCapPeripheralDefinition* peripheralDefinition = [[self alloc] initWithName:__name];
    if (__definitionBlock) {
        __definitionBlock(peripheralDefinition);
    }
    return peripheralDefinition;
}

-(id)initWithName:(NSString*)__name {
    self = [super init];
    if (self) {
        self.name = __name;
        self.definedServices = [NSMutableDictionary dictionary];
    }
    return self;
}

@end
