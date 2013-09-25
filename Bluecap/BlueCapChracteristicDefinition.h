//
//  BlueCapChracteristicDefinition.h
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BlueCapChracteristicDefinition;

typedef void(^BlueCapCharacteristicDefinitionBlock)(BlueCapChracteristicDefinition* __characteristicDefinition);

@interface BlueCapChracteristicDefinition : NSObject

+ (BlueCapChracteristicDefinition*)createWithUUID:(NSString*)__uuidString;
+ (BlueCapChracteristicDefinition*)createWithUUID:(NSString*)__uuidString image:(UIImage*)__image;

+ (BlueCapChracteristicDefinition*)createWithUUID:(NSString*)__uuidString andDefinition:(BlueCapCharacteristicDefinitionBlock)__definitionBlock;
+ (BlueCapChracteristicDefinition*)createWithUUID:(NSString*)__uuidString image:(UIImage*)__image andDefinition:(BlueCapCharacteristicDefinitionBlock)__definitionBlock;

@end
