//
//  BlueCapService+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapService+Private.h"
#import "BlueCapCharacteristic+Private.h"

@implementation BlueCapService (Private)

@dynamic cbService;
@dynamic discoveredCharacteristics;
@dynamic discoveredIncludedServices;

- (BlueCapCharacteristic*)chracteristicFor:(CBCharacteristic*)__cbCharacteristic {
    BlueCapCharacteristic* selectedCharacteristic = nil;
    for (BlueCapCharacteristic* characteristic in self.discoveredCharacteristics) {
        if ([characteristic.cbCharacteristic isEqual:__cbCharacteristic]) {
            selectedCharacteristic = characteristic;
            break;
        }
    }
    return selectedCharacteristic;
}

@end
