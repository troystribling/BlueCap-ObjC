//
//  BlueCapCharacteristic+Friend.h
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristic.h"

@class BlueCapService;
@class BlueCapCharacteristicProfile;

@interface BlueCapCharacteristic (Friend)

@property(nonatomic, retain) CBCharacteristic*                  cbCharacteristic;
@property(nonatomic, retain) NSMutableArray*                    discoveredDiscriptors;
@property(nonatomic, retain) BlueCapService*                    service;
@property(nonatomic, retain) BlueCapCharacteristicProfile*      profile;

@property(nonatomic, copy) BlueCapCharacteristicDataCallback                afterReadCallback;
@property(nonatomic, copy) BlueCapCharacteristicDataCallback                afterWriteCallback;
@property(nonatomic, copy) BlueCapDescriptorsDicoveredCallback              afterDescriptorsDiscoveredCallback;
@property(nonatomic, copy) BlueCapCharacteristicNotificationStateDidChange  notificationStateDidChangeCallback;

+ (BlueCapCharacteristic*)withCBCharacteristic:(CBCharacteristic*)__cbCharacteristics  andService:(BlueCapService*)__service;
- (id)initWithCBCharacteristic:(CBCharacteristic*)__cbCharacteristic andService:(BlueCapService*)__service;

- (void)didUpdateValue:(NSError*)error;
- (void)didUpdateNotificationState:(NSError*)error;
- (void)didWriteValue:(NSError*)error;
- (void)didDiscoverDescriptors:(NSArray*)__descriptors;

@end
