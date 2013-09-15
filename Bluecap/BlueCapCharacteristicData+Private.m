//
//  BlueCapCharacteristicData+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 9/12/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristicData+Private.h"

@implementation BlueCapCharacteristicData (Private)

@dynamic bcCharacteristic;

+ (BlueCapCharacteristicData*)withCharacteristic:(BlueCapCharacteristic*)__bcCharacteristic {
    return [[BlueCapCharacteristicData alloc] initWithCharacteristic:__bcCharacteristic];
}

- (id)initWithCharacteristic:(BlueCapCharacteristic*)__bcCharacteristic {
    self = [super init];
    if (self) {
        self.bcCharacteristic = __bcCharacteristic;
    }
    return self;
}

@end
