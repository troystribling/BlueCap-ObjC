//
//  BlueCapPeripheralDefinition+Private.h
//  BlueCap
//
//  Created by Troy Stribling on 9/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheralDefinition.h"

@interface BlueCapPeripheralDefinition (Private)

@property(nonatomic, retain) NSUUID*  identifier;

+ (BlueCapPeripheralDefinition*)createWithUUID:(NSString*)__uuidString;
+ (BlueCapPeripheralDefinition*)createWithUUID:(NSString*)__uuidString andDefinition:(BlueCapPeripheralDefinitionBlock)__definitionBlock;

-(id)initWithUUID:(NSString*)__uuidString;

@end
