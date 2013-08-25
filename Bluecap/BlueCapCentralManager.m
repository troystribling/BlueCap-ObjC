//
//  BlueCapCentralManager.m
//  BlueCap
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCentralManager.h"
#import "BlueCapPeripheral.h"

@interface BlueCapCentralManager () {
    CBCentralManager*  centralManager;
}

@end

static BlueCapCentralManager* thisBlueCapCentralManager = nil;

@implementation BlueCapCentralManager

#pragma mark -
#pragma mark BlueCapCentralManager

+ (BlueCapCentralManager*)sharedInstance {
    @synchronized(self) {
        if (thisBlueCapCentralManager == nil) {
            thisBlueCapCentralManager = [[self alloc] init];
        }
    }
    return thisBlueCapCentralManager;
}

- (id) init {
    self = [super init];
    if (self) {
		centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
		self.periphreals = [NSMutableArray array];
	}
    return self;
}

- (void)startScanning {
    DLog(@"Start Scanning");
    [centralManager scanForPeripheralsWithServices:nil options:nil];
}

- (void)startScanningForUUIDString:(NSString*)uuidString {
	NSArray			*uuidArray	= [NSArray arrayWithObjects:[CBUUID UUIDWithString:uuidString], nil];
	NSDictionary	*options	= [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
	[centralManager scanForPeripheralsWithServices:uuidArray options:options];
}

- (void) stopScanning {
	[centralManager stopScan];
}

- (void)connectPeripherial:(CBPeripheral*)peripheral {
    if (peripheral.state == CBPeripheralStateDisconnected) {
        [centralManager connectPeripheral:peripheral options:nil];
    }
}

- (void)disconnectPeripheral:(CBPeripheral*)peripheral {
    if (!peripheral.state == CBPeripheralStateDisconnected) {
        [centralManager cancelPeripheralConnection:peripheral];
    }
}

#pragma mark -
#pragma mark CBCentralManagerDelegate

- (void)centralManager:(CBCentralManager*)central didConnectPeripheral:(CBPeripheral*)peripheral {
    BlueCapPeripheral* bcperipheral = [BlueCapPeripheral withCBPeripheral:peripheral];
    DLog(@"Peripheral Connected: %@", bcperipheral.name);
    [self.delegate didConnectPeripheral:bcperipheral];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral*)peripheral error:(NSError*)error {
    BlueCapPeripheral* bcperipheral = [BlueCapPeripheral withCBPeripheral:peripheral];
    DLog(@"Peripheral Disconnected: %@", bcperipheral.name);
    [self.delegate didDisconnectPeripheral:bcperipheral];
}

- (void)centralManager:(CBCentralManager*)central
 didDiscoverPeripheral:(CBPeripheral*)peripheral
     advertisementData:(NSDictionary*)advertisementData
                  RSSI:(NSNumber*)RSSI {
    BlueCapPeripheral* bcperipheral = [BlueCapPeripheral withCBPeripheral:peripheral];
    if (![self.periphreals containsObject:bcperipheral]) {
        DLog(@"Periphreal Discovered: %@", bcperipheral.name);
        [self.periphreals addObject:bcperipheral];
        [self.delegate didDicoverPeripheral:bcperipheral];
    }
}

- (void)centralManager:(CBCentralManager*)central didFailToConnectPeripheral:(CBPeripheral*)peripheral error:(NSError*)error {
}

- (void)centralManager:(CBCentralManager*)central didRetrieveConnectedPeripherals:(NSArray*)peripherals {
}

- (void)centralManager:(CBCentralManager*)central didRetrievePeripherals:(NSArray*)peripherals {
}

- (void)centralManagerDidUpdateState:(CBCentralManager*)central {
	switch ([centralManager state]) {
		case CBCentralManagerStatePoweredOff: {
            [self.delegate didPoweredOff];
			break;
		}
		case CBCentralManagerStateUnauthorized: {
			break;
		}
		case CBCentralManagerStateUnknown: {
			break;
		}
		case CBCentralManagerStatePoweredOn: {
            DLog(@"CBCentralManager Powered ON");
            [self startScanning];
			break;
		}
		case CBCentralManagerStateResetting: {
			break;
		}
        case CBCentralManagerStateUnsupported: {
            
        }
	}
}

- (void)peripheralDidUpdateRSSI:(CBPeripheral*)peripheral error:(NSError*)error {
}

@end
