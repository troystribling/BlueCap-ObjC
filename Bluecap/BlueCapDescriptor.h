//
//  BlueCapDescriptor.h
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCommon.h"

@class BlueCapCharacteristic;

@interface BlueCapDescriptor : NSObject

@property(nonatomic, readonly) id           value;
@property(nonatomic, readonly) CBUUID*      UUID;

- (BlueCapCharacteristic*)characteristic;

- (void)read:(BlueCapCallback)__onRead;
- (void)write:(NSData*)data onWrite:(BlueCapCallback)__onWrite;
- (NSString*)typeStringValue;
- (NSString*)stringValue;

@end
