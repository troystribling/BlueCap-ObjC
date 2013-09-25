//
//  BlueCapServiceDefinition.h
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCommon.h"

@interface BlueCapServiceDefinition : NSObject

@property(nonatomic, readonly) NSUUID*  identifier;
@property(nonatomic, retain) UIImage*   image;

+ (BlueCapServiceDefinition*)createWithUUID:(NSString*)__uuidString;
+ (BlueCapServiceDefinition*)createWithUUID:(NSString*)__uuidString image:(UIImage*)__image;

+ (BlueCapServiceDefinition*)createWithUUID:(NSString*)__uuidString andDefinition:(BlueCapServiceDefinitionBlock)__definitionBlock;
+ (BlueCapServiceDefinition*)createWithUUID:(NSString*)__uuidString image:(UIImage*)__image andDefinition:(BlueCapServiceDefinitionBlock)__definitionBlock;

@end
