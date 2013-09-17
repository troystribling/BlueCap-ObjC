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

@property(nonatomic, copy) BlueCapPeripheralCallback    onPeriperialDisconnect;
@property(nonatomic, copy) BlueCapPeripheralCallback    onPeripheralConnect;
@property(nonatomic, copy) BlueCapPeripheralCallback    onPeripheralDiscovered;

+ (BlueCapPeripheral*)withCBPeripheral:(CBPeripheral*)__cbPeripheral;
- (id)initWithCBPeripheral:(CBPeripheral*)__cbPeripheral;

@end
