//
//  BlueCapCharacteristic.m
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheral.h"
#import "BlueCapService.h"
#import "BlueCapPeripheral+Private.h"
#import "BlueCapService+Private.h"
#import "BlueCapCharacteristic.h"

@interface BlueCapCharacteristic () {
}

@property(nonatomic, retain) CBCharacteristic*      cbCharacteristic;
@property(nonatomic, retain) NSMutableDictionary*   discoveredDiscriptors;

@end

@implementation BlueCapCharacteristic

#pragma mark -
#pragma mark BlueCapCharacteristic

+ (BlueCapCharacteristic*)withCBCharacteristic:(CBCharacteristic*)__cbCharacteristics  andService:(BlueCapService*)__service {
    return [[BlueCapCharacteristic alloc] initWithCBCharacteristic:__cbCharacteristics andService:__service];
}

- (id)initWithCBCharacteristic:(CBCharacteristic*)__cbCharacteristic andService:(BlueCapService*)__service {
    self = [super init];
    if (self) {
        self.cbCharacteristic = __cbCharacteristic;
        _service = __service;
        self.discoveredDiscriptors = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSArray*)descriptors {
    return [self.discoveredDiscriptors allValues];
}

- (BOOL)isBroadcasted {
    return self.cbCharacteristic.isBroadcasted;
}

-(BOOL)isNotifying {
    return self.cbCharacteristic.isNotifying;
}

-(NSArray*)properties {
    return [NSArray array];
}

-(NSData*)value {
    return self.cbCharacteristic.value;
}

- (void)discoverDescriptors {
    [_service.peripheral.cbPeripheral discoverDescriptorsForCharacteristic:self.cbCharacteristic];
}

#pragma mark -
#pragma mark BlueCapCharacteristic PrivateAPI

@end
