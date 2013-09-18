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

@property(nonatomic, readonly) CBUUID*      UUID;

- (BlueCapCharacteristic*)characteristic;

- (void)read:(BlueCapDescriptorCallback)__onReadCallback;
- (void)write:(NSData*)data onWrite:(BlueCapDescriptorCallback)__onWriteCallback;
- (NSString*)typeStringValue;

@end
