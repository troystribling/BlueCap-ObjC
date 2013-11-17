//
//  BlueCapCharacteristicProfile.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristicProfile.h"

@interface BlueCapCharacteristicProfile ()

@property(nonatomic, retain) CBUUID*                                                    UUID;
@property(nonatomic, retain) NSString*                                                  name;
@property(nonatomic, retain) NSDictionary*                                              valueObjects;
@property(nonatomic, retain) NSDictionary*                                              valueNames;
@property(nonatomic, copy) BlueCapCharacteristicProfileSerializeNamedObjectCallback     serializeNamedObjectCallback;
@property(nonatomic, copy) BlueCapCharacteristicProfileSerializeObjectCallback          serializeObjectCallback;
@property(nonatomic, copy) BlueCapCharacteristicProfileSerializeStringCallback          serializeStringValueCallback;
@property(nonatomic, copy) BlueCapCharacteristicProfileDeserializeDataCallback          deserializeDataCallback;
@property(nonatomic, copy) BlueCapCharacteristicProfileStringValueCallback              stringValueCallback;
@property(nonatomic, copy) BlueCapCharacteristicProfileAfterDiscoveredCallback          afterDiscoveredCallback;

@end

@implementation BlueCapCharacteristicProfile

- (CBUUID*)UUID {
    return _UUID;
}

- (NSString*)name {
    return _name;
}

- (BOOL)hasValues {
    return [self.valueObjects count] > 0;
}

- (NSArray*)allValues {
    NSArray* valueNames = [NSArray array];
    if ([self hasValues]) {
        valueNames = [self.valueNames allValues];
    }
    return valueNames;
}

- (BOOL)propertyEnabled:(CBCharacteristicProperties)__property {
    return self.properties & __property;
}

- (BOOL)permissionEnabled:(CBAttributePermissions)__permission {
    return self.permissions & __permission;
}

- (void)setValue:(id)__objectValue named:(NSString*)__valueName {
    [self.valueObjects setValue:__objectValue forKey:__valueName];
    [self.valueNames setValue:__valueName forKey:__objectValue];
}

- (void)serializeNamedObject:(BlueCapCharacteristicProfileSerializeNamedObjectCallback)__serializeBlock {
    self.serializeNamedObjectCallback = __serializeBlock;
}

- (void)serializeObject:(BlueCapCharacteristicProfileSerializeObjectCallback)__serializeBlock {
    self.serializeObjectCallback = __serializeBlock;
}

- (void)serializeStringValue:(BlueCapCharacteristicProfileSerializeStringCallback)__serializeBlock {
    self.serializeStringValueCallback = __serializeBlock;
}

- (void)deserializeData:(BlueCapCharacteristicProfileDeserializeDataCallback)__deserializeCallback {
    self.deserializeDataCallback = __deserializeCallback;
}

- (void)stringValue:(BlueCapCharacteristicProfileStringValueCallback)__stringValueCallback {
    self.stringValueCallback = __stringValueCallback;
}

- (void)afterDiscovered:(BlueCapCharacteristicProfileAfterDiscoveredCallback)__afterDiscoveredCallback {
    self.afterDiscoveredCallback = __afterDiscoveredCallback;
}

@end
