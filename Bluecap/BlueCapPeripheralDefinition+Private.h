//
//  BlueCapPeripheralDefinition+Private.h
//  BlueCap
//
//  Created by Troy Stribling on 9/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheralDefinition.h"

@interface BlueCapPeripheralDefinition (Private)

@property(nonatomic, retain) NSString*              name;
@property(nonatomic, retain) NSMutableDictionary*   definedServices;

+ (BlueCapPeripheralDefinition*)createWithName:(NSString*)__name andDefinition:(BlueCapPeripheralDefinitionBlock)__definitionBlock;
-(id)initWithName:(NSString*)__name;

@end
