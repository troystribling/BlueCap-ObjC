//
//  BlueCapCharacteristic.m
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristic.h"

@interface BlueCapCharacteristic () {
    CBCharacteristic* cbCharacteristic;
}

@property(nonatomic, retain) NSMutableDictionary* discoveredDiscriptors;

@end

@implementation BlueCapCharacteristic

#pragma mark -
#pragma mark BlueCapCharacteristic

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

#pragma mark -
#pragma mark BlueCapCharacteristic PrivateAPI

@end
