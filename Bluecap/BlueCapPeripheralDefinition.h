//
//  BlueCapPeripheralDefinition.h
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@interface BlueCapPeripheralDefinition : NSObject

@property(nonatomic, readonly) NSUUID*  identifier;

+ (BlueCapPeripheralDefinition*)createWithUUID:(NSString*)__uuidString;
+ (BlueCapPeripheralDefinition*)createWithUUID:(NSString*)__uuidString andDefinition:(BlueCapPeripheralDefinitionBlock)__definitionBlock;

@end
