//
//  BlueCapCentralManager.m
//  BlueCap
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCentralManager.h"
#import "BlueCapPeripheral.h"

@interface BlueCapCentralManager ()

@property(nonatomic, retain) NSMutableDictionary* discoveredPeripherals;
@property(nonatomic, retain) CBCentralManager* centralManager;

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
		self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
        self.discoveredPeripherals = [NSMutableDictionary dictionary];
	}
    return self;
}

- (NSArray*)periphreals {
    return [self.discoveredPeripherals allValues];
}

- (void)startScanning {
    DLog(@"Start Scanning");
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
}

- (void)startScanningForUUIDString:(NSString*)uuidString {
	NSArray			*uuidArray	= [NSArray arrayWithObjects:[CBUUID UUIDWithString:uuidString], nil];
	NSDictionary	*options	= [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
	[self.centralManager scanForPeripheralsWithServices:uuidArray options:options];
}

- (void) stopScanning {
	[self.centralManager stopScan];
}

- (void)connectPeripherial:(BlueCapPeripheral*)peripheral {
    if (peripheral.state == CBPeripheralStateDisconnected) {
        [peripheral connect];
    }
}

- (void)disconnectPeripheral:(BlueCapPeripheral*)peripheral {
    if (!peripheral.state == CBPeripheralStateDisconnected) {
        [peripheral disconnect];
    }
}

#pragma mark -
#pragma mark CBCentralManagerDelegate

- (void)centralManager:(CBCentralManager*)central didConnectPeripheral:(CBPeripheral*)peripheral {
    BlueCapPeripheral* bcPeripheral = [self.discoveredPeripherals objectForKey:peripheral];
    if (bcPeripheral != nil) {
        DLog(@"Peripheral Connected: %@", peripheral.name);
        if ([self.delegate respondsToSelector:@selector(didConnectPeripheral:)]) {
            [self.delegate didConnectPeripheral:bcPeripheral];
        }
    } else {
        DLog(@"Peripheral '%@' not found", peripheral.name);
    }
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral*)peripheral error:(NSError*)error {
    BlueCapPeripheral* bcPeripheral = [self.discoveredPeripherals objectForKey:peripheral];
    if (bcPeripheral != nil) {
        DLog(@"Peripheral Disconnected: %@", peripheral.name);
        if ([self.delegate respondsToSelector:@selector(didDisconnectPeripheral:)]) {
            [self.delegate didDisconnectPeripheral:bcPeripheral];
        }
    } else {
        DLog(@"Peripheral '%@' not found", peripheral.name);
    }
}

- (void)centralManager:(CBCentralManager*)central
 didDiscoverPeripheral:(CBPeripheral*)peripheral
     advertisementData:(NSDictionary*)advertisementData
                  RSSI:(NSNumber*)RSSI {
    if ([self.discoveredPeripherals objectForKey:peripheral] == nil) {
        BlueCapPeripheral* bcperipheral = [BlueCapPeripheral withCBPeripheral:peripheral];
        DLog(@"Periphreal Discovered: %@", bcperipheral.name);
        [self.discoveredPeripherals setObject:bcperipheral forKey:peripheral];
        if ([self.delegate respondsToSelector:@selector(didDiscoverPeripheral:)]) {
            [self.delegate didDiscoverPeripheral:bcperipheral];
        }
    }
}

- (void)centralManager:(CBCentralManager*)central didFailToConnectPeripheral:(CBPeripheral*)peripheral error:(NSError*)error {
}

- (void)centralManager:(CBCentralManager*)central didRetrieveConnectedPeripherals:(NSArray*)peripherals {
}

- (void)centralManager:(CBCentralManager*)central didRetrievePeripherals:(NSArray*)peripherals {
}

- (void)centralManagerDidUpdateState:(CBCentralManager*)central {
	switch ([central state]) {
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
