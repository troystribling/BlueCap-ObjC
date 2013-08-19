//
//  BlueCapManager.m
//  BlueCap
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapManager.h"
#import "DebugLog.h"

@interface BlueCapManager () {
    CBCentralManager*  centralManager;
}

@end

static BlueCapManager* thisBlueCapManager = nil;

@implementation BlueCapManager

#pragma mark -
#pragma mark BlueCapManager

+ (BlueCapManager*)sharedInstance {
    @synchronized(self) {
        if (thisBlueCapManager == nil) {
            thisBlueCapManager = [[self alloc] init];
        }
    }
    return thisBlueCapManager;
}

- (id) init {
    self = [super init];
    if (self) {
		centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
		self.foundPeriphreals = [NSMutableArray array];
		self.connectedPeriphreals = [NSMutableArray array];
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

#pragma mark -
#pragma mark CBPeripheralDelegate

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverCharacteristicsForService:(CBService*)service error:(NSError*)error {
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverIncludedServicesForService:(CBService*)service error:(NSError*)error {
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverServices:(NSError*)error {
}

- (void)peripheral:(CBPeripheral*)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
}

- (void)peripheral:(CBPeripheral*)peripheral didUpdateValueForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
}

- (void)peripheral:(CBPeripheral*)peripheral didUpdateValueForDescriptor:(CBDescriptor*)descriptor error:(NSError*)error {
}

- (void)peripheral:(CBPeripheral*)peripheral didWriteValueForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
}

- (void)peripheral:(CBPeripheral*)peripheral didWriteValueForDescriptor:(CBDescriptor*)descriptor error:(NSError*)error {
}

#pragma mark -
#pragma mark CBCentralManagerDelegate

- (void)centralManager:(CBCentralManager*)central didConnectPeripheral:(CBPeripheral*)peripheral {
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral*)peripheral error:(NSError*)error {
}

- (void)centralManager:(CBCentralManager*)central
 didDiscoverPeripheral:(CBPeripheral*)peripheral
     advertisementData:(NSDictionary*)advertisementData RSSI:(NSNumber*)RSSI {
    DLog(@"Periphreal Discovered: %@", peripheral.name);
    [self.blueCapManagerDelegate didRefresh];
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
            [self.blueCapManagerDelegate didPoweredOff];
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
