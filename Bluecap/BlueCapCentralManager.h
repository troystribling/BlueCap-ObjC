//
//  BlueCapCentralManager.h
//  BlueCap
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

@class BlueCapPeripheral;

@protocol BlueCapCentralManagerDelegate <NSObject>

@optional

- (void)didPoweredOff;
- (void)didDicoverPeripheral:(BlueCapPeripheral*)peripheral;
- (void)didConnectPeripheral:(BlueCapPeripheral*)peripheral;
- (void)didDisconnectPeripheral:(BlueCapPeripheral*)peripheral;

@end


@interface BlueCapCentralManager : NSObject <CBCentralManagerDelegate>

@property(nonatomic, retain) NSMutableArray*                    periphreals;
@property(nonatomic, weak) id<BlueCapCentralManagerDelegate>    delegate;

+ (BlueCapCentralManager*)sharedInstance;
- (void)startScanning;
- (void)startScanningForUUIDString:(NSString*)uuidString;
- (void) stopScanning;

- (void)connectPeripherial:(CBPeripheral*)peripheral;
- (void)disconnectPeripheral:(CBPeripheral*)peripheral;

@end
