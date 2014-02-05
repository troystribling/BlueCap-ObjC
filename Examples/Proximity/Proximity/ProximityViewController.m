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
- (void)getServicesAndCharacteristics:(BlueCapPeripheral*)peripheral;

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
        [self getServicesAndCharacteristics:cPeripheral];
    }];
}

- (void)getServicesAndCharacteristics:(BlueCapPeripheral*)peripheral {
    [peripheral discoverAllServicesAndCharacteristics:^(BlueCapPeripheral* peripheral, NSError* error) {
    }];
}


@end
