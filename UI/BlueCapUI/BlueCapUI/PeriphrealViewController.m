//
//  PeriphrealViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 8/19/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "PeriphrealViewController.h"

@interface PeriphrealViewController ()


@end

@implementation PeriphrealViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.periphreal.name;
    if (self.periphreal.state == CBPeripheralStateDisconnected) {
        [self.connectButton setTitle:@"Connect" forState:UIControlStateNormal];
    } else {
        [self.connectButton setTitle:@"Disconnect" forState:UIControlStateNormal];
    }
    [self.periphreal readRSSI];
    if (self.periphreal.RSSI) {
        self.rssiTextField.text = [NSString stringWithFormat:@"%@dB", self.periphreal.RSSI];
    } else {
        self.rssiTextField.text = @"Unknown";
    }
    self.uuidTextField.text = self.periphreal.identifier.UUIDString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
