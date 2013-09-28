//
//  BlueCapPeripheralDefinition.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheralDefinition.h"

@interface BlueCapPeripheralDefinition ()

@property(nonatomic, retain) NSUUID*                identifier;
@property(nonatomic, retain) NSMutableDictionary*   definedServices;

@end

@implementation BlueCapPeripheralDefinition

#pragma mark -
#pragma mark Service Definition

-(NSUUID*)identifier {
    return _identifier;
}

- (BlueCapServiceDefinition*)createServiceWithUUID:(NSString*)__uuidString andName:(NSString*)__name {
    return [self createServiceWithUUID:__uuidString name:__name andDefinition:nil];
}

- (BlueCapServiceDefinition*)createServiceWithUUID:(NSString*)__uuidString name:(NSString*)__name andDefinition:(BlueCapServiceDefinitionBlock)__definitionBlock {
    return nil;
}

@end
