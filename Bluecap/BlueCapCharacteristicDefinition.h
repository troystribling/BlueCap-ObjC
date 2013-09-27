//
//  BlueCapCharacteristicDefinition.h
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@interface BlueCapCharacteristicDefinition : NSObject

@property(nonatomic, readonly) CBUUID*      UUID;
@property(nonatomic, retain) NSString*      name;

+ (BlueCapCharacteristicDefinition*)createWithUUID:(NSString*)__uuidString andName:(NSString*)__name;
+ (BlueCapCharacteristicDefinition*)createWithUUID:(NSString*)__uuidString name:(NSString*)__name andDefinition:(BlueCapCharacteristicDefinitionBlock)__definitionBlock;

@end
