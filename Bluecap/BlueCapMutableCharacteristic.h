//
//  BlueCapMutableCharacteristic.h
//  BlueCap
//
//  Created by Troy Stribling on 11/4/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@class BlueCapCharacteristicProfile;

@interface BlueCapMutableCharacteristic : NSObject

@property(nonatomic, readonly) NSArray*                                 descriptors;
@property(nonatomic, readonly) NSArray*                                 subscribedCentrals;
@property(nonatomic, readonly) CBAttributePermissions                   permissions;
@property(nonatomic, readonly) CBCharacteristicProperties               properties;
@property(nonatomic, readonly) CBUUID*                                  UUID;
@property(nonatomic, readonly) NSString*                                name;

@property(nonatomic, retain, readonly) BlueCapCharacteristicProfile*    profile;

+ (BlueCapMutableCharacteristic*)withProfile:(BlueCapCharacteristicProfile*)__profile andObject:(id)__value;
+ (BlueCapMutableCharacteristic*)withProfile:(BlueCapCharacteristicProfile*)__profile andData:(NSData*)__value;
+ (BlueCapMutableCharacteristic*)withProfile:(BlueCapCharacteristicProfile*)__profile andString:(NSString*)__value;
+ (BlueCapMutableCharacteristic*)withProfile:(BlueCapCharacteristicProfile*)__profile andNamedValue:(NSString*)__name;
+ (BlueCapMutableCharacteristic*)withProfile:(BlueCapCharacteristicProfile*)__profile;

+ (NSArray*)withProfiles:(NSArray*)__profiles;

- (BOOL)hasValues;
- (BOOL)propertyEnabled:(CBCharacteristicProperties)__property;
- (BOOL)permissionEnabled:(CBAttributePermissions)__permission;

- (void)processWriteRequest:(BlueCapMutableCharacteristicCallback)__processWriteRequestBlock;

- (NSData*)dataValue;
- (NSDictionary*)value;
- (NSDictionary*)stringValue;

- (void)updateValueObject:(id)__value;
- (void)updateValueString:(NSString*)__value;
- (void)updateValueData:(NSData*)__value;
- (void)updateValueNamed:(NSString*)__name;

@end
