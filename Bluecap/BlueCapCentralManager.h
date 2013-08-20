//
//  BlueCapCentralManager.h
//  BlueCap
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

@protocol BlueCapCentralManagerDelegate <NSObject>

- (void) didRefreshPeriferals;
- (void) didPoweredOff;

@end


@interface BlueCapCentralManager : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

@property(nonatomic, retain) NSMutableArray*                    foundPeriphreals;
@property(nonatomic, retain) NSMutableArray*                    connectedPeriphreals;
@property(nonatomic, weak) id<BlueCapCentralManagerDelegate>    delegate;

+ (BlueCapCentralManager*)sharedInstance;
- (void)startScanning;
- (void)startScanningForUUIDString:(NSString*)uuidString;
- (void) stopScanning;

@end
