//
//  BlueCapCentralManager.m
//  BlueCap
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCentralManager+Private.h"
#import "BlueCapPeripheral+Private.h"


@interface BlueCapCentralManager ()

@property(nonatomic, retain) NSMutableDictionary*           discoveredPeripherals;
@property(nonatomic, retain) CBCentralManager*              centralManager;
@property(nonatomic, retain) dispatch_queue_t               mainQueue;
@property(nonatomic, retain) dispatch_queue_t               callbackQueue;
@property(nonatomic, copy) BlueCapCentralManagerCallback    onPowerOffCallback;
@property(nonatomic, copy) BlueCapCentralManagerCallback    onPowerOnCallback;
@property(nonatomic, copy) BlueCapPeripheralCallback        onPeripheralDiscoveredCallback;
@property(nonatomic, assign) BOOL                           poweredOn;

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
        self.mainQueue = dispatch_queue_create("com.gnos.us.main", DISPATCH_QUEUE_SERIAL);
        self.callbackQueue = dispatch_queue_create("com.gnos.us.callback", DISPATCH_QUEUE_SERIAL);
		self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:self.mainQueue];
        self.discoveredPeripherals = [NSMutableDictionary dictionary];
        self.poweredOn = YES;
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

- (void)startScanning:(BlueCapPeripheralCallback)__onPeripheralDiscoveredCallback {
    DLog(@"Start Scanning");
    self.onPeripheralDiscoveredCallback = __onPeripheralDiscoveredCallback;
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
}

- (void)startScanningForUUIDString:(NSString*)uuidString onDiscovery:(BlueCapPeripheralCallback)__onPeripheralDiscoveredCallback {
	NSArray			*uuidArray	= [NSArray arrayWithObjects:[CBUUID UUIDWithString:uuidString], nil];
	NSDictionary	*options	= [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
    self.onPeripheralDiscoveredCallback = __onPeripheralDiscoveredCallback;
	[self.centralManager scanForPeripheralsWithServices:uuidArray options:options];
}

- (void)stopScanning {
	[self.centralManager stopScan];
    [self syncMain:^{
        self.onPeripheralDiscoveredCallback = nil;
    }];
}

- (void)powerOn:(BlueCapCentralManagerCallback)__onPowerOnCallback {
    self.onPowerOnCallback = __onPowerOnCallback;
    [self syncMain:^{
        if (!self.poweredOn) {
            [self asyncCallback:^{
                self.onPowerOnCallback();
            }];
        }
    }];
}

- (void)powerOn:(BlueCapCentralManagerCallback)__onPowerOnCallback onPowerOff:(BlueCapCentralManagerCallback)__onPowerOffCallback {
    self.onPowerOffCallback = __onPowerOffCallback;
    [self powerOn:__onPowerOnCallback];
}

#pragma mark -
#pragma mark CBCentralManagerDelegate

- (void)centralManager:(CBCentralManager*)central didConnectPeripheral:(CBPeripheral*)peripheral {
    BlueCapPeripheral* bcPeripheral = [self.discoveredPeripherals objectForKey:peripheral];
    if (bcPeripheral != nil) {
        DLog(@"Peripheral Connected: %@", peripheral.name);
        [bcPeripheral didConnectPeripheral:bcPeripheral];
    } else {
        DLog(@"Peripheral '%@' not found", peripheral.name);
    }
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral*)peripheral error:(NSError*)error {
    BlueCapPeripheral* bcPeripheral = [self.discoveredPeripherals objectForKey:peripheral];
    if (bcPeripheral != nil) {
        DLog(@"Peripheral Disconnected: %@", peripheral.name);
        [bcPeripheral didDisconnectPeripheral:bcPeripheral];
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
        if (self.onPeripheralDiscoveredCallback != nil) {
            [self asyncCallback:^{
                self.onPeripheralDiscoveredCallback(bcperipheral);
            }];
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
            if (self.onPowerOffCallback != nil) {
                self.poweredOn = NO;
                [self asyncCallback:^{
                    self.onPowerOffCallback();
                }];
            }
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
            self.poweredOn = YES;
            if (self.onPowerOnCallback) {
                [self asyncCallback:^{
                    self.onPowerOnCallback();
                }];
            }
			break;
		}
		case CBCentralManagerStateResetting: {
			break;
		}
        case CBCentralManagerStateUnsupported: {
            
        }
	}
}

- (void)peripheralDidUpdateRSSI:(CBPeripheral*)peripheral error:(NSError*)__error {
    BlueCapPeripheral* bcPeripheral = [self.discoveredPeripherals objectForKey:peripheral];
    if (bcPeripheral != nil) {
        DLog(@"Peripheral RSSI Updated: %@", peripheral.name);
        [bcPeripheral didUpdateRSSI:bcPeripheral error:__error];
    } else {
        DLog(@"Peripheral '%@' not found", peripheral.name);
    }
}

@end
