//
//  BlueCapService.h
//  BlueCap
//
//  Created by Troy Stribling on 8/24/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

@class BlueCapPeripheral;
@class BlueCapService;
@class BlueCapCharacteristic;

@protocol BlueCapServiceDelegate <NSObject>

- (void)didDiscoverCharacteristicsForService:(BlueCapService*)service error:(NSError*)error;
- (void)didDiscoverDescriptorsForCharacteristic:(BlueCapCharacteristic*)characteristic error:(NSError*)error;

@end

@interface BlueCapService : NSObject

@property(nonatomic, weak)     id<BlueCapServiceDelegate>   delegate;
@property(nonatomic, readonly) CBUUID*                      UUID;
@property(nonatomic, readonly) NSArray*                     characteristics;
@property(nonatomic, readonly) NSArray*                     includedServices;
@property(nonatomic, readonly) BOOL                         isPrimary;

+ (BlueCapService*)withCBService:(CBService*)__cbservice andPeripheral:(BlueCapPeripheral*)__peripheral;

- (void)discoverAllCharacteritics;
- (void)discoverCharacteristics:(NSArray*)__characteristics;

@end
