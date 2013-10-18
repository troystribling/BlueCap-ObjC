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

@property(nonatomic, retain) CBPeripheral*                  cbPeripheral;
@property(nonatomic, retain) NSMutableArray*                discoveredServices;
@property(nonatomic, retain) NSMapTable*                    discoveredObjects;

@property(nonatomic, copy) BlueCapPeripheralCallback        afterPeriperialDisconnectCallback;
@property(nonatomic, copy) BlueCapPeripheralCallback        afterPeripheralConnectCallback;

+ (BlueCapPeripheral*)withCBPeripheral:(CBPeripheral*)__cbPeripheral;
- (id)initWithCBPeripheral:(CBPeripheral*)__cbPeripheral;

- (void)didDisconnectPeripheral:(BlueCapPeripheral*)__peripheral;
- (void)didConnectPeripheral:(BlueCapPeripheral*)__peripheral;

@end
