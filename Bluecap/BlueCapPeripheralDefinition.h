//
//  BlueCapPeripheralDefinition.h
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlueCapCentralManager+Private.h"

@interface BlueCapPeripheralDefinition : NSObject

@property(nonatomic, readonly) NSUUID*  identifier;
@property(nonatomic, retain) UIImage*   image;

+ (void)createWithUUID:(NSString*)__uuidString andDefinition:(BlueCapPeripheralDefinitionBlock)__definitionBlock;
+ (void)createWithUUID:(NSString*)__uuidString image:(UIImage*)__image andDefinition:(BlueCapPeripheralDefinitionBlock)__definitionBlock;

@end