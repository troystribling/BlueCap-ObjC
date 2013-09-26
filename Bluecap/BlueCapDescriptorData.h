//
//  BlueCapDescriptorData.h
//  BlueCap
//
//  Created by Troy Stribling on 9/11/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@class BlueCapDescriptor;

@interface BlueCapDescriptorData : NSObject

@property(nonatomic, readonly) BlueCapDescriptor* descriptor;

- (NSString*)stringValue;
- (NSNumber*)numberValue;
- (NSData*)dataValue;

@end
