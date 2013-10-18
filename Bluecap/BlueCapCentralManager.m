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
@property(nonatomic, retain) NSMutableDictionary*           serviceProfiles;
@property(nonatomic, retain) CBCentralManager*              centralManager;
@property(nonatomic, retain) dispatch_queue_t               mainQueue;
@property(nonatomic, retain) dispatch_queue_t               callbackQueue;
@property(nonatomic, assign) BOOL                           poweredOn;

@property(nonatomic, copy) BlueCapCentralManagerCallback    afterPowerOffCallback;
@property(nonatomic, copy) BlueCapCentralManagerCallback    afterPowerOnCallback;
@property(nonatomic, copy) BlueCapPeripheralCallback        afterPeripheralDiscoveredCallback;

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
        self.serviceProfiles = [NSMutableDictionary dictionary];
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

#pragma mark -
#pragma mark Service Profile

- (BlueCapServiceProfile*)createServiceWithUUID:(NSString*)__uuidString andName:(NSString*)__name {
    return [self createServiceWithUUID:__uuidString name:__name andProfile:nil];
}

- (BlueCapServiceProfile*)createServiceWithUUID:(NSString*)__uuidString name:(NSString*)__name andProfile:(BlueCapServiceProfileBlock)__profileBlock {
    BlueCapServiceProfile* serviceProfile = [BlueCapServiceProfile createWithUUID:__uuidString name:__name andProfile:__profileBlock];
    [self.serviceProfiles setObject:serviceProfile forKey:serviceProfile.UUID];
    DLog(@"Service Profile Defined: %@-%@", serviceProfile.name, [serviceProfile.UUID stringValue]);
    return serviceProfile;
}

#pragma mark -
#pragma mark Scan for Periherals

- (void)startScanning:(BlueCapPeripheralCallback)__afterPeripheralDiscoveredCallback {
    DLog(@"Start Scanning");
    self.afterPeripheralDiscoveredCallback = __afterPeripheralDiscoveredCallback;
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
}

- (void)startScanningForPeripheralsWithServiceUUIDs:(NSArray*)__uuids onDiscovery:(BlueCapPeripheralCallback)__afterPeripheralDiscoveredCallback {
	NSDictionary	*options	= [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
    self.afterPeripheralDiscoveredCallback = __afterPeripheralDiscoveredCallback;
    [self.discoveredPeripherals removeAllObjects];
	[self.centralManager scanForPeripheralsWithServices:__uuids options:options];
}

- (void)stopScanning {
	[self.centralManager stopScan];
}

#pragma mark -
#pragma mark Power On

- (void)powerOn:(BlueCapCentralManagerCallback)__onPowerOnCallback {
    self.afterPowerOnCallback = __onPowerOnCallback;
    [self syncMain:^{
        if (self.poweredOn) {
            [self asyncCallback:^{
                self.afterPowerOnCallback();
            }];
        }
    }];
}

- (void)powerOn:(BlueCapCentralManagerCallback)__onPowerOnCallback onPowerOff:(BlueCapCentralManagerCallback)__afterPowerOffCallback {
    self.afterPowerOffCallback = __afterPowerOffCallback;
    [self powerOn:__onPowerOnCallback];
}


- (void)createPeripheralWithUUID:(NSString*)__uuidString andConfiguration:(BlueCapPeripheralCallback)__configurationBlock {
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

- (void)centralManager:(CBCentralManager*)central didDiscoverPeripheral:(CBPeripheral*)peripheral advertisementData:(NSDictionary*)advertisementData RSSI:(NSNumber*)RSSI {
    if ([self.discoveredPeripherals objectForKey:peripheral] == nil) {
        BlueCapPeripheral* bcperipheral = [BlueCapPeripheral withCBPeripheral:peripheral];
        DLog(@"Periphreal Discovered: %@-%@", bcperipheral.name, [peripheral.identifier UUIDString]);
        [self.discoveredPeripherals setObject:bcperipheral forKey:peripheral];
        if (self.afterPeripheralDiscoveredCallback != nil) {
            [self asyncCallback:^{
                self.afterPeripheralDiscoveredCallback(bcperipheral);
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
            DLog(@"CBCentralManager Powered OFF");
            if (self.afterPowerOffCallback != nil) {
                self.poweredOn = NO;
                [self asyncCallback:^{
                    self.afterPowerOffCallback();
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
            if (self.afterPowerOnCallback) {
                [self asyncCallback:^{
                    self.afterPowerOnCallback();
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

@end
