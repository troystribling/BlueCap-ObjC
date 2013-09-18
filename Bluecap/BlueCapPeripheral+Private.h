//
//  BlueCapPeripheral+Private.h
//  BlueCap
//
//  Created by Troy Stribling on 8/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheral.h"

@interface BlueCapPeripheral (Private)

@property(nonatomic, retain) CBPeripheral*          cbPeripheral;
@property(nonatomic, retain) NSMutableArray*        discoveredServices;
@property(nonatomic, retain) NSMapTable*            discoveredObjects;

@property(nonatomic, copy) BlueCapPeripheralCallback        onPeriperialDisconnect;
@property(nonatomic, copy) BlueCapPeripheralCallback        onPeripheralConnect;
@property(nonatomic, copy) BlueCapPeripheralRSSICallback    onRSSIUpdate;

+ (BlueCapPeripheral*)withCBPeripheral:(CBPeripheral*)__cbPeripheral;
- (id)initWithCBPeripheral:(CBPeripheral*)__cbPeripheral;

- (void)didDisconnectPeripheral:(BlueCapPeripheral*)__peripheral;
- (void)didConnectPeripheral:(BlueCapPeripheral*)__peripheral;
- (void)didUpdateRSSI:(BlueCapPeripheral*)__peripheral error:(NSError*)__error;

@end
