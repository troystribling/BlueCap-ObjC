//
//  BlueCapCentralManager.m
//  BlueCap
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCentralManager+Friend.h"
#import "BlueCapPeripheral+Friend.h"
#import "BlueCapServiceProfile+Friend.h"
#import "CBUUID+StringValue.h"

@interface BlueCapCentralManager ()

@property(nonatomic, retain) NSMutableDictionary*           discoveredPeripherals;
@property(nonatomic, retain) CBCentralManager*              centralManager;
@property(nonatomic, retain) dispatch_queue_t               mainQueue;
@property(nonatomic, retain) dispatch_queue_t               callbackQueue;
@property(nonatomic, assign) BOOL                           poweredOn;
@property(nonatomic, assign) BOOL                           connecting;

@property(nonatomic, copy) BlueCapCentralManagerCallback        afterPowerOffCallback;
@property(nonatomic, copy) BlueCapCentralManagerCallback        afterPowerOnCallback;
@property(nonatomic, copy) BlueCapPeripheralDiscoveredCallback  afterPeripheralDiscoveredCallback;

// DEBUG
@property(nonatomic, strong) CBPeripheral* cbPeripheral;
- (void)connect:(CBPeripheral*)__peripheral;
// END DEBUG

@end

static BlueCapCentralManager* thisBlueCapCentralManager = nil;

@implementation BlueCapCentralManager

#pragma mark - BlueCapCentralManager

+ (BlueCapCentralManager*)sharedInstance {
    @synchronized(self) {
        if (thisBlueCapCentralManager == nil) {
            thisBlueCapCentralManager = [[self alloc] init];
        }
    }
    return thisBlueCapCentralManager;
}

- (id)init {
    self = [super init];
    if (self) {
        self.mainQueue = dispatch_queue_create("com.gnos.us.central.main", DISPATCH_QUEUE_SERIAL);
        self.callbackQueue = dispatch_queue_create("com.gnos.us.centrail.callback", DISPATCH_QUEUE_SERIAL);
		self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        self.discoveredPeripherals = [NSMutableDictionary dictionary];
        self.poweredOn = NO;
        self.connecting = NO;
        _isScanning = NO;
	}
    return self;
}

- (NSArray*)periphreals {
    __block NSArray* __periperals = [NSArray array];
    [self syncMain:^{
        __periperals = [self.discoveredPeripherals allValues];
    }];
    return __periperals;
}

#pragma mark - Scan for Periherals

- (void)startScanning:(BlueCapPeripheralDiscoveredCallback)__afterPeripheralDiscoveredCallback {
    [self startScanningForPeripheralsWithServiceUUIDs:nil afterDiscovery:__afterPeripheralDiscoveredCallback];
}

- (void)startScanningForPeripheralsWithServiceUUIDs:(NSArray*)__uuids afterDiscovery:(BlueCapPeripheralDiscoveredCallback)__afterPeripheralDiscoveredCallback {
    if (!_isScanning) {
        _isScanning = YES;
        DLog(@"Start Scanning");
        NSDictionary* options = @{CBCentralManagerScanOptionAllowDuplicatesKey:[NSNumber numberWithBool:NO]};
        self.afterPeripheralDiscoveredCallback = __afterPeripheralDiscoveredCallback;
        [self.discoveredPeripherals removeAllObjects];
        [self.centralManager scanForPeripheralsWithServices:__uuids options:options];
    }
}

- (void)stopScanning {
    if (_isScanning) {
        _isScanning = NO;
        [self.centralManager stopScan];
    }
}

- (void)disconnectAllPeripherals {
    for (BlueCapPeripheral* peripheral in [self.discoveredPeripherals allValues]) {
        [peripheral disconnect];
    }
}

#pragma mark - Power On

- (void)powerOn:(BlueCapCentralManagerCallback)__afterPowerOnCallback {
    self.afterPowerOnCallback = __afterPowerOnCallback;
    [self syncMain:^{
        if (self.poweredOn && self.afterPowerOnCallback) {
            [self asyncCallback:^{
                self.afterPowerOnCallback();
            }];
        }
    }];
}

- (void)powerOn:(BlueCapCentralManagerCallback)__afterPowerOnCallback afterPowerOff:(BlueCapCentralManagerCallback)__afterPowerOffCallback {
    self.afterPowerOffCallback = __afterPowerOffCallback;
    [self powerOn:__afterPowerOnCallback];
}


#pragma mark - CBCentralManagerDelegate

- (void)centralManager:(CBCentralManager*)central didConnectPeripheral:(CBPeripheral*)peripheral {
// DEBUG
//    BlueCapPeripheral* bcPeripheral = [self.discoveredPeripherals objectForKey:peripheral];
//    if (bcPeripheral != nil) {
//        DLog(@"Peripheral Connected: %@", peripheral.name);
//        [bcPeripheral didConnectPeripheral:bcPeripheral];
//    } else {
//        DLog(@"Peripheral '%@' not found", peripheral.name);
//    }
    DLog(@"Peripheral connected: %@", peripheral.name);
    self.cbPeripheral = peripheral;
    self.cbPeripheral.delegate = self;
    [self.cbPeripheral discoverServices:nil];

// END DEBUG
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral*)peripheral error:(NSError*)error {
// DEBUG
//    BlueCapPeripheral* bcPeripheral = [self.discoveredPeripherals objectForKey:peripheral];
//    if (bcPeripheral != nil) {
//        DLog(@"Peripheral Disconnected: %@", peripheral.name);
//        [bcPeripheral didDisconnectPeripheral:bcPeripheral];
//    } else {
//        DLog(@"Peripheral '%@' not found", peripheral.name);
//    }
    if ([peripheral.name isEqualToString:@"Bond"]) {
        DLog(@"Peripheral disconnected: %@", peripheral.name);
         [self connect:peripheral];
    }

// END DEBUG
}

- (void)centralManager:(CBCentralManager*)central didDiscoverPeripheral:(CBPeripheral*)peripheral advertisementData:(NSDictionary*)advertisements RSSI:(NSNumber*)RSSI {
// DEBUG
    if ([self.discoveredPeripherals objectForKey:peripheral] == nil && [peripheral.name isEqualToString:@"Bond"]) {
//    if ([self.discoveredPeripherals objectForKey:peripheral] == nil) {
        BlueCapPeripheral* bcperipheral = [BlueCapPeripheral withCBPeripheral:peripheral];
        bcperipheral.advertisement = advertisements;
        DLog(@"Periphreal Discovered: %@, %@\n%@", bcperipheral.name, [peripheral.identifier UUIDString], bcperipheral.advertisement);
//        [self.discoveredPeripherals setObject:bcperipheral forKey:peripheral];
        if (self.afterPeripheralDiscoveredCallback != nil) {
            [self connect:peripheral];
//            [self asyncCallback:^{
//                self.afterPeripheralDiscoveredCallback(bcperipheral, RSSI);
//            }];
        }
    }
//    if ([peripheral.name isEqualToString:@"Bond"]) {
//        DLog(@"Periphreal discovered: %@, %@\n%@", peripheral.name, [peripheral.identifier UUIDString], advertisements);
//        [self connect:peripheral];
//    }
// END DEBUG
}

// DEBUG
- (void)connect:(CBPeripheral*)__peripheral {
    self.cbPeripheral = __peripheral;
    self.cbPeripheral.delegate = self;
    [self.centralManager connectPeripheral:self.cbPeripheral options:nil];
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverServices:(NSError*)error {
    for (CBService* service in peripheral.services) {
        NSLog(@"Discovered Service: %@", [service.UUID stringValue]);
        [self.cbPeripheral discoverCharacteristics:nil forService:service];
    }
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverIncludedServicesForService:(CBService*)service error:(NSError*)error {
    DLog(@"Discovered %lu Included Services", (unsigned long)[service.includedServices count]);
}

- (void)peripheral:(CBPeripheral*)peripheral didDiscoverCharacteristicsForService:(CBService*)service error:(NSError*)error {
    for (CBCharacteristic* characteritc in service.characteristics) {
        NSLog(@"Discovered chracteristic: %@", [characteritc.UUID stringValue]);
        [self.cbPeripheral readValueForCharacteristic:characteritc];
    }
}

- (void)peripheral:(CBPeripheral*)peripheral didUpdateValueForCharacteristic:(CBCharacteristic*)characteristic error:(NSError*)error {
    if (error) {
        DLog(@"Error: %@", [error localizedDescription]);
    } else {
        DLog(@"Update value for characteristic: %@", [characteristic.UUID stringValue]);
    }
}
// END DEBUG

- (void)centralManager:(CBCentralManager*)central didFailToConnectPeripheral:(CBPeripheral*)peripheral error:(NSError*)error {
}

- (void)centralManager:(CBCentralManager*)central didRetrieveConnectedPeripherals:(NSArray*)peripherals {
}

- (void)centralManager:(CBCentralManager*)central didRetrievePeripherals:(NSArray*)peripherals {
}

- (void)centralManagerDidUpdateState:(CBCentralManager*)central {
	switch ([central state]) {
		case CBCentralManagerStatePoweredOff: {
            DLog(@"CBCentralManager Powered OFF");
            if (self.afterPowerOffCallback) {
                self.poweredOn = NO;
                [self asyncCallback:^{
                    self.afterPowerOffCallback();
                }];
            }
			break;
		}
		case CBCentralManagerStateUnauthorized: {
            DLog(@"CBCentralManager Unauthorized");
			break;
		}
		case CBCentralManagerStateUnknown: {
            DLog(@"CBCentralManager Unknown");
			break;
		}
		case CBCentralManagerStatePoweredOn: {
            DLog(@"CBCentralManager Powered ON");
            self.poweredOn = YES;
            if (self.afterPowerOnCallback) {
                [self asyncCallback:^{
                    self.afterPowerOnCallback();
                }];
            }
			break;
		}
		case CBCentralManagerStateResetting: {
            DLog(@"CBCentralManager Resetting");
			break;
		}
        case CBCentralManagerStateUnsupported: {
            DLog(@"CBCentralManager Unsupported");
        }
	}
}

@end
