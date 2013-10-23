//
//  PeripheralDetailViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 8/19/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "PeripheralDetailViewController.h"
#import "PeripheralServicesViewController.h"

@interface PeripheralDetailViewController ()

- (IBAction)disconnect:(id)sender;
- (void)updateUSSI;

@end

@implementation PeripheralDetailViewController

#pragma mark - PeripheralViewController

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
    self.uuidLabel.text = self.peripheral.identifier.UUIDString;
    [self updateUSSI];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.peripheral recieveRSSIUpdates:^(BlueCapPeripheral* periheral, NSError* error) {
        [self updateUSSI];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.peripheral dropRSSIUpdates];
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

#pragma mark - PeripheralViewController PrivateAPI

- (void)updateUSSI {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.peripheral.RSSI) {
            self.rssiLabel.text = [NSString stringWithFormat:@"%@dB", self.peripheral.RSSI];
        } else {
            self.rssiLabel.text = @"Unknown";
        }
    });
}

@end
