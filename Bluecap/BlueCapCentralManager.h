//
//  BlueCapCentralManager.h
//  BlueCap
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@interface BlueCapCentralManager : NSObject <CBCentralManagerDelegate>

@property(nonatomic, readonly, retain) NSArray*     periphreals;

+ (BlueCapCentralManager*)sharedInstance;

- (void)startScanning:(BlueCapPeripheralDiscoveredCallback)__afterPeripheralDiscoveredCallback;
- (void)startScanningForPeripheralsWithServiceUUIDs:(NSArray*)__uuids onDiscovery:(BlueCapPeripheralDiscoveredCallback)__afterPeripheralDiscoveredCallback;
- (void)stopScanning;

- (void)powerOn:(BlueCapCentralManagerCallback)__afterPowerOnCallback;
- (void)powerOn:(BlueCapCentralManagerCallback)__afterPowerOnCallback onPowerOff:(BlueCapCentralManagerCallback)__afterPowerOffCallback;

- (BlueCapServiceProfile*)createServiceWithUUID:(NSString*)__uuidString andName:(NSString*)__name;
- (BlueCapServiceProfile*)createServiceWithUUID:(NSString*)__uuidString name:(NSString*)__name andProfile:(BlueCapServiceProfileBlock)__profileBlock;

@end
