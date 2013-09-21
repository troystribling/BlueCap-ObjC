//
//  BlueCapCharacteristicData.m
//  BlueCap
//
//  Created by Troy Stribling on 9/11/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCentralManager+Private.h"
#import "BlueCapCharacteristic+Private.h"
#import "BlueCapCharacteristicData+Private.h"

@interface BlueCapCharacteristicData ()

@property(nonatomic, retain) BlueCapCharacteristic* bcCharacteristic;

@end

@implementation BlueCapCharacteristicData

- (BlueCapCharacteristic*) characteristic {
    return self.bcCharacteristic;
}

-(NSData*)value {
    __block NSData* __value = [NSData data];
    [[BlueCapCentralManager sharedInstance] syncMain:^{
        __value = self.bcCharacteristic.cbCharacteristic.value;
    }];
    return __value;
}

@end
