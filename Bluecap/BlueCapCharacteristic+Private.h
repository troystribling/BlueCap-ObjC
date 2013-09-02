//
//  BlueCapCharacteristic+Private.h
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristic.h"

@interface BlueCapCharacteristic (Private)

@property(nonatomic, retain) CBCharacteristic*      cbCharacteristic;
@property(nonatomic, retain) NSMutableDictionary*   discoveredDiscriptors;
@property(nonatomic, retain) BlueCapService*        service;
@property(nonatomic, copy) BlueCapCallback          onRead;
@property(nonatomic, copy) BlueCapCallback          onWrite;

+ (BlueCapCharacteristic*)withCBCharacteristic:(CBCharacteristic*)__cbCharacteristics  andService:(BlueCapService*)__service;
- (id)initWithCBCharacteristic:(CBCharacteristic*)__cbCharacteristic andService:(BlueCapService*)__service;

- (void)didUpdateValue:(NSError*)error;
- (void)didUpdateNotificationState:(NSError*)error;
- (void)didWriteValue:(NSError*)error;

@end
