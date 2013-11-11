//
//  BlueCapMutableCharacteristic.h
//  BlueCap
//
//  Created by Troy Stribling on 11/4/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <Foundation/Foundation.h>

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
+ (BlueCapMutableCharacteristic*)withProfile:(BlueCapCharacteristicProfile*)__profile;
+ (BlueCapMutableCharacteristic*)withProfile:(BlueCapCharacteristicProfile*)__profile andNamedValue:(NSString*)__name;

- (BlueCapCharacteristicProfile*)profile;
- (BOOL)propertyEnabled:(CBCharacteristicProperties)__property;
- (BOOL)permissionEnabled:(CBAttributePermissions)__permission;

- (NSData*)dataValue;
- (NSDictionary*)value;
- (NSDictionary*)stringValue;

- (void)updateValueString:(NSString*)__value;
- (void)updateValueNamed:(NSString*)__name;
- (void)updateData:(NSData*)__value;

@end
