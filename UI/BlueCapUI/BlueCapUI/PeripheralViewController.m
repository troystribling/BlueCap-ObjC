//
//  PeripheralViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 8/19/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "PeripheralViewController.h"

@interface PeripheralViewController ()

@end

@implementation PeripheralViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.peripheral.name;
    if (self.peripheral.state == CBPeripheralStateDisconnected) {
        self.connectedLabel.text = @"Yes";
    } else {
        self.connectedLabel.text = @"No";
    }
    [self.peripheral readRSSI];
    if (self.peripheral.RSSI) {
        self.rssiLabel.text = [NSString stringWithFormat:@"%@dB", self.peripheral.RSSI];
    } else {
        self.rssiLabel.text = @"Unknown";
    }
    self.uuidLabel.text = self.peripheral.identifier.UUIDString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Private

@end
