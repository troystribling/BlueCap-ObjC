//
//  PeripheralViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 8/19/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "PeripheralViewController.h"
#import "PeripheralServicesViewController.h"

#define RECONNECT_DELAY         2.0f
#define MAX_FAILED_RECONNECTS   10

@interface PeripheralViewController ()

@property(nonatomic, assign) NSInteger connectionSequenceNumber;

- (IBAction)toggleConnection:(id)sender;
- (void)updateUSSI;
- (void)setConnectButtonLabel;
- (void)connect;
- (void)reconnect;

@end

@implementation PeripheralViewController

#pragma mark - PeripheralViewController -

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
    [self setConnectButtonLabel];
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

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PeripheralServices"]) {
        PeripheralServicesViewController* viewController = segue.destinationViewController;
        viewController.peripheral = self.peripheral;
    }
}

#pragma mark - Private -

- (IBAction)toggleConnection:(id)sender {
    if (self.peripheral.state == CBPeripheralStateConnected) {
        [self.peripheral disconnect];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        self.connectionSequenceNumber = 0;
        [self connect];
    }
}

- (void)setConnectButtonLabel {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.peripheral.state == CBPeripheralStateConnected) {
            [self.connectButton setTitle:@"Disconnect" forState:UIControlStateNormal];
            [self.connectButton setTitleColor:[UIColor colorWithRed:0.7 green:0.1 blue:0.1 alpha:1.0] forState:UIControlStateNormal];
        } else {
            [self.connectButton setTitle:@"Connect" forState:UIControlStateNormal];
            [self.connectButton setTitleColor:[UIColor colorWithRed:0.1 green:0.7 blue:0.1 alpha:1.0] forState:UIControlStateNormal];
        }
    });
}
                   
- (void)updateUSSI {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.peripheral.RSSI) {
            self.rssiLabel.text = [NSString stringWithFormat:@"%@dB", self.peripheral.RSSI];
        } else {
            self.rssiLabel.text = @"Unknown";
        }
    });
}

- (void)connect {
    [self.peripheral connect:^(BlueCapPeripheral* peripheral, NSError* error) {
        if (error) {
            [self reconnect];
        } else {
            [self setConnectButtonLabel];
        }
    } afterPeripheralDisconnect:^(BlueCapPeripheral* peripheral) {
        [self reconnect];
    }];
}

- (void)reconnect {
    if (self.connectionSequenceNumber < MAX_FAILED_RECONNECTS) {
        DLog(@"Attempting reconnect sequence number: %d", self.connectionSequenceNumber);
        self.connectionSequenceNumber++;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(RECONNECT_DELAY * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [self connect];
        });
    } else {
        DLog(@"Maximum reconnections exceeded for sequence number: %d", self.connectionSequenceNumber);
    }
}

@end
