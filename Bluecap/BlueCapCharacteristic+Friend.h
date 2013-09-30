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
@property(nonatomic, copy) BlueCapCharacteristicDataCallback    onReadCallback;
@property(nonatomic, copy) BlueCapCharacteristicDataCallback    onWriteCallback;
@property(nonatomic, copy) BlueCapDescriptorsDicoveredCallback  onDescriptorsDiscoveredCallback;
@property(nonatomic, retain) BlueCapCharacteristicProfile*      profile;

+ (BlueCapCharacteristic*)withCBCharacteristic:(CBCharacteristic*)__cbCharacteristics  andService:(BlueCapService*)__service;
- (id)initWithCBCharacteristic:(CBCharacteristic*)__cbCharacteristic andService:(BlueCapService*)__service;

- (void)didUpdateValue:(NSError*)error;
- (void)didUpdateNotificationState:(NSError*)error;
- (void)didWriteValue:(NSError*)error;
- (void)didDiscoverDescriptors:(NSArray*)__descriptors;

@end
