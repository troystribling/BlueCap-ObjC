//
//  BlueCapManager.h
//  BlueCap
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

@interface BlueCapManager : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

+ (BlueCapManager*)sharedInstance;
- (void)startScanning;
- (void)startScanningForUUIDString:(NSString*)uuidString;
- (void) stopScanning;

@end
