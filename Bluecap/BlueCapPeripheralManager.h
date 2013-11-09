//
//  BlueCapPeripheralManager.h
//  BlueCap
//
//  Created by Troy Stribling on 11/3/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@interface BlueCapPeripheralManager : NSObject <CBPeripheralManagerDelegate>

@property(nonatomic, readonly) BOOL                         isAdvertising;
@property(nonatomic, readonly) CBPeripheralManagerState     state;
@property(nonatomic, readonly) NSArray*                     services;

+(BlueCapPeripheralManager*)sharedInstance;

- (void)startAdvertising:(NSString*)__name afterStart:(BlueCapPeripheralManagerStartedAdvertising)__startedAdvertisingCallback;
- (void)stopAdvertising:(BlueCapPeripheralManagerStoppedAdvertising)__stoppedAdvertisingCallback;

@end
