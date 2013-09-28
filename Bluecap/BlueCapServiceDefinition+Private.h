//
//  BlueCapServiceDefinition+Private.h
//  BlueCap
//
//  Created by Troy Stribling on 9/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapServiceDefinition.h"

@interface BlueCapServiceDefinition (Private)

@property(nonatomic, retain) CBUUID*                        UUID;
@property(nonatomic, retain) NSString*                      name;
@property(nonatomic, retain) NSMutableDictionary*           definedCharacteristics;
@property(nonatomic, retain) BlueCapServiceDefinition*      definition;


+ (BlueCapServiceDefinition*)createWithUUID:(NSString*)__uuidString name:(NSString*)__name andDefinition:(BlueCapServiceDefinitionBlock)__definitionBlock;

- (id)initWithUUID:(NSString*)__uuidString andName:(NSString*)__name;

@end
