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

- (void)toggelScan;

@end

@implementation ProximityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Private

- (void)toggelScan {
    BlueCapCentralManager* central = [BlueCapCentralManager sharedInstance];
    if (central.isScanning) {
        
    } else {
        [central powerOn:^{
            [central disconnectAllPeripherals];
        } afterPowerOff:^{
        }];
    }
}

@end
