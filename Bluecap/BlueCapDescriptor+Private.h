//
//  BlueCapDescriptor+Private.h
//  BlueCap
//
//  Created by Troy Stribling on 8/31/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapDescriptor.h"

@interface BlueCapDescriptor (Private)

@property(nonatomic, retain) CBDescriptor*              cbDescriptor;
@property(nonatomic, retain) BlueCapCharacteristic*   characteristic;

+ (BlueCapDescriptor*)withCBDiscriptor:(CBDescriptor*)__descriptor andChracteristic:(BlueCapCharacteristic*)__chracteristic;
- (id)initWithCBDiscriptor:(CBDescriptor*)__descriptor andChracteristic:(BlueCapCharacteristic*)__chracteristic;

@end
