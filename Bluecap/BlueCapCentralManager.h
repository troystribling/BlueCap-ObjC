//
//  BlueCapCentralManager.h
//  BlueCap
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCommon.h"

@class BlueCapPeripheral;
@class BlueCapPeripheralDefinition;

typedef void(^BlueCapCentralManagerCallback)(void);
typedef void(^BlueCapPeripheralCallback)(BlueCapPeripheral* __peripheral);
typedef void(^BlueCapPeripheralDefinitionBlock)(BlueCapPeripheralDefinition* __peripheralDefinition);


@interface BlueCapCentralManager : NSObject <CBCentralManagerDelegate>

@property(nonatomic, readonly, retain) NSArray*                 periphreals;

+ (BlueCapCentralManager*)sharedInstance;

- (void)startScanning:(BlueCapPeripheralCallback)__onPeripheralDiscoveredCallback;
- (void)startScanningForUUIDString:(NSString*)uuidString onDiscovery:(BlueCapPeripheralCallback)__onPeripheralDiscoveredCallback;
- (void)stopScanning;

- (void)powerOn:(BlueCapCentralManagerCallback)__onPowerOnCallback;
- (void)powerOn:(BlueCapCentralManagerCallback)__onPowerOnCallback onPowerOff:(BlueCapCentralManagerCallback)__onPowerOffCallback;

- (void)createPeripheralDefinitionWithUUID:(NSString*)__uuidString andDefinition:(BlueCapPeripheralDefinitionBlock)__definitionBlock;
- (void)createPeripheralDefinitionWithUUID:(NSString*)__uuidString image:(UIImage*)__image andDefinition:(BlueCapPeripheralDefinitionBlock)__definitionBlock;

@end
