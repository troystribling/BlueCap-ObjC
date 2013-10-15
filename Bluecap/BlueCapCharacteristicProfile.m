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
@property(nonatomic, retain) NSMutableDictionary*                                       serializeBlocks;
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

- (void)serializeValueNamed:(NSString*)__valueName usingBlock:(BlueCapCharacteristicProfileSerializeValueCallback)__serializeBlock {
    [self.serializeBlocks setObject:[__serializeBlock copy] forKey:__valueName];
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
