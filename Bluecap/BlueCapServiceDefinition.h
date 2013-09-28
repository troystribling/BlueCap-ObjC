//
//  BlueCapServiceDefinition.h
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@class BlueCapCharacteristicDefinition;

@interface BlueCapServiceDefinition : NSObject

- (CBUUID*)UUID;
- (NSString*)name;

- (BlueCapCharacteristicDefinition*)createCharacteristicWithUUID:(NSString*)__uuidString andName:(NSString*)__name;
- (BlueCapCharacteristicDefinition*)createCharacteristicWithUUID:(NSString*)__uuidString name:(NSString*)__name andDefinition:(BlueCapCharacteristicDefinitionBlock)__definitionBlock;

@end
