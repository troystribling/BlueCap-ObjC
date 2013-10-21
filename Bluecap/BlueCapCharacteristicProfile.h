//
//  BlueCapCharacteristicProfile.h
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@interface BlueCapCharacteristicProfile : NSObject

- (CBUUID*)UUID;
- (NSString*)name;

- (void)defineObject:(id)__date withName:(NSString*)__valueName;
- (void)serializeNamedObject:(BlueCapCharacteristicProfileSerializeNamedObjectCallback)__serializeBlock;
- (void)serializeObject:(BlueCapCharacteristicProfileSerializeObjectCallback)__serializeBlock;

- (void)deserializeData:(BlueCapCharacteristicProfileDeserializeDataCallback)__deserializeCallback;
- (void)stringValue:(BlueCapCharacteristicProfileStringValueCallback)__stringValueCallback;
- (void)afterDiscovered:(BlueCapCharacteristicProfileAfterDiscoveredCallback)__afterDiscoveredCallback;

@end
