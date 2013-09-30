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
@property(nonatomic, retain) BlueCapPeripheralProfile*      profile;

@property(nonatomic, copy) BlueCapPeripheralCallback        onPeriperialDisconnectCallback;
@property(nonatomic, copy) BlueCapPeripheralCallback        onPeripheralConnectCallback;
@property(nonatomic, copy) BlueCapPeripheralRSSICallback    onRSSIUpdateCallback;

+ (BlueCapPeripheral*)withCBPeripheral:(CBPeripheral*)__cbPeripheral;
- (id)initWithCBPeripheral:(CBPeripheral*)__cbPeripheral;

- (void)didDisconnectPeripheral:(BlueCapPeripheral*)__peripheral;
- (void)didConnectPeripheral:(BlueCapPeripheral*)__peripheral;
- (void)didUpdateRSSI:(BlueCapPeripheral*)__peripheral error:(NSError*)__error;

@end
