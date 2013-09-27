//
//  BlueCapServiceDefinition.h
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@interface BlueCapServiceDefinition : NSObject

@property(nonatomic, readonly) CBUUID*      UUID;
@property(nonatomic, retain) NSString*      name;

+ (BlueCapServiceDefinition*)createWithUUID:(NSString*)__uuidString andName:(NSString*)__name;
+ (BlueCapServiceDefinition*)createWithUUID:(NSString*)__uuidString name:(NSString*)__name andDefinition:(BlueCapServiceDefinitionBlock)__definitionBlock;

@end
