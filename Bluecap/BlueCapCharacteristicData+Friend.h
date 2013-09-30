//
//  BlueCapCharacteristicData+Friend.h
//  BlueCap
//
//  Created by Troy Stribling on 9/12/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristicData.h"

@class BlueCapCharacteristic;

@interface BlueCapCharacteristicData (Friend)

@property(nonatomic, retain) BlueCapCharacteristic*   bcCharacteristic;

+ (BlueCapCharacteristicData*)withCharacteristic:(BlueCapCharacteristic*)__bcCharacteristic;
- (id)initWithCharacteristic:(BlueCapCharacteristic*)__bcCharacteristic;

@end
