//
//  BlueCapCharacteristicValue+Private.h
//  BlueCap
//
//  Created by Troy Stribling on 9/12/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristicValue.h"

@class BlueCapCharacteristic;

@interface BlueCapCharacteristicValue (Private)

@property(nonatomic, retain) BlueCapCharacteristic*   bcCharacteristic;

+ (BlueCapCharacteristicValue*)withCharacteristic:(BlueCapCharacteristic*)__bcCharacteristic;
- (id)initWithCharacteristic:(BlueCapCharacteristic*)__bcCharacteristic;

@end
