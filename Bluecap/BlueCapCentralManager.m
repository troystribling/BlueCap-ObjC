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
@property(nonatomic, retain) dispatch_queue_t               centralManagerQueue;
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
        self.centralManagerQueue = dispatch_queue_create("com.gnos.us.centralManager", DISPATCH_QUEUE_SERIAL);
		self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:self.centralManagerQueue];
        self.discoveredPeripherals = [NSMutableDictionary dictionary];
        self.poweredOn = YES;
	}
    return self;
}

- (NSArray*)periphreals {
    __block NSArray* __periperals = [NSArray array];
    [[BlueCapCentralManager sharedInstance] sync:^{
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

- (void) stopScanning {
	[self.centralManager stopScan];
    [self sync:^{
        self.onPeripheralDiscoveredCallback = nil;
    }];
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

- (void)powerOn:(BlueCapCentralManagerCallback)__onPowerOnCallback {
    self.onPowerOnCallback = __onPowerOnCallback;
    [self sync:^{
        if (!self.poweredOn) {
            self.onPowerOnCallback();
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
        if ([self.delegate respondsToSelector:@selector(didConnectPeripheral:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate didConnectPeripheral:bcPeripheral];
            });
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
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate didDisconnectPeripheral:bcPeripheral];
            });
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
        if (self.onPeripheralDiscoveredCallback != nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.onPeripheralDiscoveredCallback(bcperipheral);
            });
        }
        if ([self.delegate respondsToSelector:@selector(didDiscoverPeripheral:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate didDiscoverPeripheral:bcperipheral];
            });
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
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.onPowerOffCallback();
                });
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
            dispatch_async(dispatch_get_main_queue(), ^{
                self.onPowerOnCallback();
            });
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
