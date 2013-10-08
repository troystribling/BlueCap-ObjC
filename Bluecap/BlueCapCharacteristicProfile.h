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

- (void)serializeValueNamed:(NSString*)__valueName usingBlock:(BlueCapCharacteristicProfileSerializeCallback)__serializeBlock;
- (void)serialize:(BlueCapCharacteristicProfileSerializeWithDataCallback)__serializeBlock;
- (void)deserialize:(BlueCapCharacteristicProfileDeserializeCallback)__deserializeCallback;
- (void)afterDiscovered:(BlueCapCharacteristicProfileAfterDiscoveredCallback)__afterDiscoveredCallback;

@end
