//
//  BlueCapChracteristicDefinition.h
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@interface BlueCapChracteristicDefinition : NSObject

+ (BlueCapChracteristicDefinition*)createWithUUID:(NSString*)__uuidString;
+ (BlueCapChracteristicDefinition*)createWithUUID:(NSString*)__uuidString andDefinition:(BlueCapCharacteristicDefinitionBlock)__definitionBlock;

@end
