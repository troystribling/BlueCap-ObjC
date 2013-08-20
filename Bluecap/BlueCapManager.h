//
//  BlueCapManager.h
//  BlueCap
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

@protocol BlueCapManagerDelegate <NSObject>

- (void) didRefreshPeriferals;
- (void) didPoweredOff;

@end


@interface BlueCapManager : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

@property(nonatomic, retain) NSMutableArray*            foundPeriphreals;
@property(nonatomic, retain) NSMutableArray*            connectedPeriphreals;
@property(nonatomic, weak) id<BlueCapManagerDelegate>   blueCapManagerDelegate;

+ (BlueCapManager*)sharedInstance;
- (void)startScanning;
- (void)startScanningForUUIDString:(NSString*)uuidString;
- (void) stopScanning;

@end
