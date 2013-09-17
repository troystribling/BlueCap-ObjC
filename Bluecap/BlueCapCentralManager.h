//
//  BlueCapCentralManager.h
//  BlueCap
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

@class BlueCapPeripheral;

@protocol BlueCapCentralManagerDelegate <NSObject>

typedef void(^BlueCapCentralManagerCallback)(void);

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
- (void)startScanning;
- (void)startScanningForUUIDString:(NSString*)uuidString;
- (void)stopScanning;

- (void)onPowerOff:(BlueCapCentralManagerCallback)__onPowerOffCallback;

@end
