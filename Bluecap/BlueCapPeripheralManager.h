//
//  BlueCapPeripheralManager.h
//  BlueCap
//
//  Created by Troy Stribling on 11/3/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@class BlueCapMutableService;

@interface BlueCapPeripheralManager : NSObject <CBPeripheralManagerDelegate>

@property(nonatomic, readonly) BOOL                         isAdvertising;
@property(nonatomic, readonly) CBPeripheralManagerState     state;
@property(nonatomic, readonly) NSArray*                     services;

+(BlueCapPeripheralManager*)sharedInstance;

- (void)startAdvertising:(NSString*)__name afterStart:(BlueCapPeripheralManagerCallback)__startedAdvertisingCallback;
- (void)stopAdvertising:(BlueCapPeripheralManagerCallback)__stoppedAdvertisingCallback;

- (void)powerOn:(BlueCapCentralManagerCallback)__afterPowerOnCallback;
- (void)powerOn:(BlueCapCentralManagerCallback)__afterPowerOnCallback afterPowerOff:(BlueCapCentralManagerCallback)__afterPowerOffCallback;

- (void)addService:(BlueCapMutableService*)__service whenCompleteCall:(BlueCapPeripheralManagerAfterServiceAdded)__afterServiceAddedCallback;
- (void)removeService:(BlueCapMutableService*)__service afterRemoved:(BlueCapPeripheralManagerCallback)__afterServiceRemovedCallback;
- (void)removeAllServices:(BlueCapPeripheralManagerCallback)__afterServiceRemovedCallback;

@end
