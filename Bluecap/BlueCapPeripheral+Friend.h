//
//  BlueCapPeripheral+Friend.h
//  BlueCap
//
//  Created by Troy Stribling on 8/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheral.h"

@class BlueCapPeripheralProfile;

@interface BlueCapPeripheral (Friend)

@property(nonatomic, retain) CBPeripheral*      cbPeripheral;
@property(nonatomic, retain) NSMutableArray*    discoveredServices;
@property(nonatomic, retain) NSMapTable*        discoveredObjects;
@property(nonatomic, retain) NSDictionary*      advertisement;

@property(nonatomic, copy) BlueCapPeripheralDisconnectCallback      afterPeriperialDisconnectCallback;
@property(nonatomic, copy) BlueCapPeripheralConnectCallback         afterPeripheralConnectCallback;

@property(nonatomic, assign) BLueCapPeripheralConnectionError   currentError;
@property(nonatomic, assign) NSInteger                          connectionSequenceNumber;
@property(nonatomic, assign) BOOL                               autoReconnect;

+ (BlueCapPeripheral*)withCBPeripheral:(CBPeripheral*)__cbPeripheral;
- (id)initWithCBPeripheral:(CBPeripheral*)__cbPeripheral;

- (void)didDisconnectPeripheral:(BlueCapPeripheral*)__peripheral;
- (void)didConnectPeripheral:(BlueCapPeripheral*)__peripheral;

- (NSError*)error;

@end
