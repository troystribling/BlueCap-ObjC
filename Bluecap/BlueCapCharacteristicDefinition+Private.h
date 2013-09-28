//
//  BlueCapCharacteristicDefinition+Private.h
//  BlueCap
//
//  Created by Troy Stribling on 9/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristicDefinition.h"

@interface BlueCapCharacteristicDefinition (Private)

@property(nonatomic, retain) CBUUID*        UUID;
@property(nonatomic, retain) NSString*      name;

+ (BlueCapCharacteristicDefinition*)createWithUUID:(NSString*)__uuidString andName:(NSString*)__name;
+ (BlueCapCharacteristicDefinition*)createWithUUID:(NSString*)__uuidString name:(NSString*)__name andDefinition:(BlueCapCharacteristicDefinitionBlock)__definitionBlock;

-(id)initWithUUID:(NSString*)__uuidString andName:(NSString*)__name;

@end
