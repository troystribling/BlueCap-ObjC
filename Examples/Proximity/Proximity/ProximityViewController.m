//
//  ProximityViewController.m
//  Proximity
//
//  Created by Troy Stribling on 1/30/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "ProximityViewController.h"

@interface ProximityViewController ()

- (void)powerOn;
- (void)startScan;
- (void)connectPeripheral:(BlueCapPeripheral*)peripheral;
- (void)getServices:(BlueCapPeripheral*)peripheral;
- (void)getCharacteritics:(BlueCapService*)service;
- (void)getCharacteristicValues:(BlueCapCharacteristic*)characteristic;

@end

@implementation ProximityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self powerOn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Private

- (void)powerOn {
    BlueCapCentralManager* central = [BlueCapCentralManager sharedInstance];
    if (!central.isScanning) {
        [central powerOn:^{
            [self startScan];
        } afterPowerOff:^{
        }];
    }
}

- (void)startScan {
    BlueCapCentralManager* central = [BlueCapCentralManager sharedInstance];
    [central startScanning:^(BlueCapPeripheral* peripheral, NSNumber* RSSI) {
        [self connectPeripheral:peripheral];
    }];
}

- (void)connectPeripheral:(BlueCapPeripheral*)peripheral {
    [peripheral connectAndReconnectOnDisconnect:^(BlueCapPeripheral* cPeripheral, NSError* __error) {
//        [self getServices:cPeripheral];
    }];
}

- (void)getServices:(BlueCapPeripheral*)peripheral {
    [peripheral discoverAllServices:^(NSArray* services) {
        for (BlueCapService* service in services) {
            [self getCharacteritics:service];
        }
    }];
}

- (void)getCharacteritics:(BlueCapService*)service {
    [service discoverAllCharacteritics:^(NSArray* charcteristics) {
        for (BlueCapCharacteristic* characteristic in charcteristics) {
            [self getCharacteristicValues:characteristic];
        }
    }];
}

- (void)getCharacteristicValues:(BlueCapCharacteristic*)characteristic {
    [characteristic readData:^(BlueCapCharacteristic* rCharacteristic, NSError* error) {
        DLog(@"Characteristic value: %@", [rCharacteristic stringValue]);
    }];
}

@end
