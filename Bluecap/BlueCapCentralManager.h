//
//  BlueCapCentralManager.h
//  BlueCap
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@interface BlueCapCentralManager : NSObject <CBCentralManagerDelegate>

@property(nonatomic, readonly) NSArray*                 periphreals;

+ (BlueCapCentralManager*)sharedInstance;

- (void)startScanning:(BlueCapPeripheralDiscoveredCallback)__afterPeripheralDiscoveredCallback;
- (void)startScanningForPeripheralsWithServiceUUIDs:(NSArray*)__uuids afterDiscovery:(BlueCapPeripheralDiscoveredCallback)__afterPeripheralDiscoveredCallback;
- (void)stopScanning;

- (void)powerOn:(BlueCapCentralManagerCallback)__afterPowerOnCallback;
- (void)powerOn:(BlueCapCentralManagerCallback)__afterPowerOnCallback afterPowerOff:(BlueCapCentralManagerCallback)__afterPowerOffCallback;

@end
