//
//  BlueCapCharacteristicValue+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 9/12/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristicValue+Private.h"

@implementation BlueCapCharacteristicValue (Private)

@dynamic bcCharacteristic;

+ (BlueCapCharacteristicValue*)withCharacteristic:(BlueCapCharacteristic*)__bcCharacteristic {
    return [[BlueCapCharacteristicValue alloc] initWithCharacteristic:__bcCharacteristic];
}

- (id)initWithCharacteristic:(BlueCapCharacteristic*)__bcCharacteristic {
    self = [super init];
    if (self) {
        self.bcCharacteristic = __bcCharacteristic;
    }
    return self;
}

@end
