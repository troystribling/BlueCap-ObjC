//
//  BlueCapServiceDefinition.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapServiceDefinition+Private.h"
#import "BlueCapCharacteristicDefinition+Private.h"
#import "CBUUID+StringValue.h"

@interface BlueCapServiceDefinition ()

@property(nonatomic, retain) CBUUID*                UUID;
@property(nonatomic, retain) NSString*              name;
@property(nonatomic, retain) NSMutableDictionary*   definedCharacteristics;

@end

@implementation BlueCapServiceDefinition

- (CBUUID*)UUID {
    return _UUID;
}

- (NSString*)name {
    return _name;
}

#pragma mark -
#pragma mark Characteristic Definition

- (BlueCapCharacteristicDefinition*)createCharacteristicWithUUID:(NSString*)__uuidString andName:(NSString*)__name {
    return [self createCharacteristicWithUUID:__uuidString name:__name andDefinition:nil];
}

- (BlueCapCharacteristicDefinition*)createCharacteristicWithUUID:(NSString*)__uuidString name:(NSString*)__name andDefinition:(BlueCapCharacteristicDefinitionBlock)__definitionBlock {
    BlueCapCharacteristicDefinition* chracteristicDefinition = [BlueCapCharacteristicDefinition createWithUUID:__uuidString name:__name andDefinition:__definitionBlock];
    [self.definedCharacteristics setObject:chracteristicDefinition forKey:chracteristicDefinition.UUID];
    DLog(@"Characteristic Defined: %@-%@", chracteristicDefinition.name, [chracteristicDefinition.UUID stringValue]);
    return chracteristicDefinition;
}

@end
