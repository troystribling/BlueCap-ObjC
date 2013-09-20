//
//  BlueCapCentralManager.h
//  BlueCap
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCommon.h"

@class BlueCapPeripheral;

@protocol BlueCapCentralManagerDelegate <NSObject>

@optional

- (void)didPoweredOff;
- (void)didDiscoverPeripheral:(BlueCapPeripheral*)peripheral;
- (void)didConnectPeripheral:(BlueCapPeripheral*)peripheral;
- (void)didDisconnectPeripheral:(BlueCapPeripheral*)peripheral;

@end


@interface BlueCapCentralManager : NSObject <CBCentralManagerDelegate>

@property(nonatomic, readonly, retain) NSArray*                 periphreals;
@property(nonatomic, weak) id<BlueCapCentralManagerDelegate>    delegate;

+ (BlueCapCentralManager*)sharedInstance;
- (void)startScanning:(BlueCapPeripheralCallback)__onPeripheralDiscoveredCallback;
- (void)startScanningForUUIDString:(NSString*)uuidString onDiscovery:(BlueCapPeripheralCallback)__onPeripheralDiscoveredCallback;
- (void)stopScanning;

- (void)powerOn:(BlueCapCentralManagerCallback)__onPowerOnCallback;
- (void)powerOn:(BlueCapCentralManagerCallback)__onPowerOnCallback onPowerOff:(BlueCapCentralManagerCallback)__onPowerOffCallback;

@end
