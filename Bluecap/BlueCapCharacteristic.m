//
//  BlueCapCharacteristic.m
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheral.h"
#import "BlueCapPeripheral+Private.h"
#import "BlueCapCharacteristic.h"

@interface BlueCapCharacteristic () {
    CBCharacteristic*   cbCharacteristic;
    BlueCapPeripheral*  peripheral;
}

@property(nonatomic, retain) NSMutableDictionary* discoveredDiscriptors;

@end

@implementation BlueCapCharacteristic

#pragma mark -
#pragma mark BlueCapCharacteristic

+ (BlueCapCharacteristic*)withCBCharacteristic:(CBCharacteristic*)__cbCharacteristics andPeripheral:(BlueCapPeripheral*)__peripheral {
    return [[BlueCapCharacteristic alloc] initWithCBCharacteristic:__cbCharacteristics andPeripheral:__peripheral];
}

- (id)initWithCBCharacteristic:(CBCharacteristic*)__cbCharacteristics andPeripheral:(BlueCapPeripheral*)__peripheral {
    self = [super init];
    if (self) {
        peripheral = __peripheral;
    }
    return self;
}

- (NSArray*)descriptors {
    return [self.discoveredDiscriptors allValues];
}

- (BOOL)isBroadcasted {
    return cbCharacteristic.isBroadcasted;
}

-(BOOL)isNotifying {
    return cbCharacteristic.isNotifying;
}

-(NSArray*)properties {
    return [NSArray array];
}

-(NSData*)value {
    return cbCharacteristic.value;
}

- (void)discoverDescriptors {
    [peripheral.cbPeripheral discoverDescriptorsForCharacteristic:cbCharacteristic];
}

#pragma mark -
#pragma mark BlueCapCharacteristic PrivateAPI

@end
