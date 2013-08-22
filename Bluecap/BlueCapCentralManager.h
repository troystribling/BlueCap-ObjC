//
//  BlueCapCentralManager.h
//  BlueCap
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

@protocol BlueCapCentralManagerDelegate <NSObject>

- (void)didRefreshPeriferals;
- (void)didPoweredOff;
- (void)didConnectPeripheral:(CBPeripheral*)peripheral;
- (void)didDisconnectPeripheral:(CBPeripheral*)peripheral;

@end


@interface BlueCapCentralManager : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

@property(nonatomic, retain) NSMutableArray*                    periphreals;
@property(nonatomic, weak) id<BlueCapCentralManagerDelegate>    delegate;

+ (BlueCapCentralManager*)sharedInstance;
- (void)startScanning;
- (void)startScanningForUUIDString:(NSString*)uuidString;
- (void) stopScanning;

- (void)connectPeripherial:(CBPeripheral*)peripheral;
- (void)disconnectPeripheral:(CBPeripheral*)peripheral;

@end
