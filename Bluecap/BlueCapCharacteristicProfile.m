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
@property(nonatomic, retain) NSDictionary*                                              objectValues;
@property(nonatomic, copy) BlueCapCharacteristicProfileSerializeNamedObjectCallback     serializeNamedObjectCallback;
@property(nonatomic, copy) BlueCapCharacteristicProfileSerializeObjectCallback          serializeObjectCallback;
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

- (void)setObjectValue:(id)__objectValue named:(NSString*)__valueName {
    [self.objectValues setValue:__objectValue forKey:__valueName];
}

- (void)serializeNamedObject:(BlueCapCharacteristicProfileSerializeNamedObjectCallback)__serializeBlock {
    self.serializeNamedObjectCallback = __serializeBlock;
}

- (void)serializeObject:(BlueCapCharacteristicProfileSerializeObjectCallback)__serializeBlock {
    self.serializeObjectCallback = __serializeBlock;
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
