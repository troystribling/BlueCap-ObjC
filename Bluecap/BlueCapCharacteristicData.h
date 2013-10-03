//
//  BlueCapCharacteristicValue.h
//  BlueCap
//
//  Created by Troy Stribling on 9/11/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@class BlueCapCharacteristic;

@interface BlueCapCharacteristicData : NSObject

@property(nonatomic, readonly) BlueCapCharacteristic* characteristic;
@property(nonatomic, readonly) NSData* value;

- (NSString*)stringValue;
- (NSArray*)processedValues;

@end
