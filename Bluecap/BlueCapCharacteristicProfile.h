//
//  BlueCapCharacteristicProfile.h
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@interface BlueCapCharacteristicProfile : NSObject

@property(nonatomic, assign) CBAttributePermissions         permissions;
@property(nonatomic, assign) CBCharacteristicProperties     properties;
@property(nonatomic, retain) NSData*                        initialValue;

- (CBUUID*)UUID;
- (NSString*)name;
- (BOOL)hasValues;
- (NSArray*)allValues;

- (BOOL)propertyEnabled:(CBCharacteristicProperties)__property;
- (BOOL)permissionEnabled:(CBAttributePermissions)__permission;

- (void)setValue:(id)__objectValue named:(NSString*)__valueName;
- (void)serializeNamedObject:(BlueCapCharacteristicProfileSerializeNamedObjectCallback)__serializeBlock;
- (void)serializeObject:(BlueCapCharacteristicProfileSerializeObjectCallback)__serializeBlock;
- (void)serializeString:(BlueCapCharacteristicProfileSerializeStringCallback)__serializeBlock;

- (void)deserializeData:(BlueCapCharacteristicProfileDeserializeDataCallback)__deserializeCallback;
- (void)stringValue:(BlueCapCharacteristicProfileStringValueCallback)__stringValueCallback;
- (void)afterDiscovered:(BlueCapCharacteristicProfileAfterDiscoveredCallback)__afterDiscoveredCallback;

- (NSData*)valueFromObject:(id)__value;
- (NSData*)valueFromNamedObject:(NSString*)__name;
- (NSData*)valueFromString:(NSDictionary*)__value;

@end
