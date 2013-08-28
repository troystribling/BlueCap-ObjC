//
//  PeripheralViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 8/19/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "PeripheralViewController.h"
#import "PeripheralServicesViewController.h"

@interface PeripheralViewController ()

@end

@implementation PeripheralViewController

#pragma mark -
#pragma mark PeripheralViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.peripheral.name;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
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

- (IBAction)disconnect:(id)sender {
    [self.peripheral disconnect];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PeripheralServices"]) {
        PeripheralServicesViewController* viewController = segue.destinationViewController;
        viewController.peripheral = self.peripheral;
    }
}

#pragma mark -
#pragma mark PeripheralViewController PrivateAPI

@end
