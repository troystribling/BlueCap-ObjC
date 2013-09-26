//
//  BlueCapServiceDefinition.h
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@interface BlueCapServiceDefinition : NSObject

@property(nonatomic, readonly) NSUUID*  identifier;

+ (BlueCapServiceDefinition*)createWithUUID:(NSString*)__uuidString;
+ (BlueCapServiceDefinition*)createWithUUID:(NSString*)__uuidString andDefinition:(BlueCapServiceDefinitionBlock)__definitionBlock;

@end
