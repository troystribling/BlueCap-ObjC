//
//  PeriphrealsViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "PeripheralsViewController.h"
#import "PeripheralViewController.h"
#import "PeripheralCell.h"

@interface PeripheralsViewController ()

@property(nonatomic, retain) UIBarButtonItem*  startScanBarButtonItem;
@property(nonatomic, retain) UIBarButtonItem*  stopScanBarButtonItem;

- (IBAction)toggelScan;
- (void)reloadTableData;
- (void)setScanButton;
- (void)enterForground;

@end

@implementation PeripheralsViewController

#pragma mark - PeripheralsViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.startScanBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(toggelScan)];
    self.stopScanBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(toggelScan)];
    [self reloadTableData];
    [self setScanButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForground) name:UIApplicationWillEnterForegroundNotification object:nil];
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self reloadTableData];
}

- (void)viewWillDisappear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"PeripheralDetail"]) {
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForCell:sender];
        PeripheralViewController *viewController = segue.destinationViewController;
        viewController.peripheral = [[BlueCapCentralManager sharedInstance].periphreals objectAtIndex:selectedRowIndex.row];
    }
}

#pragma mark - Private

- (void)reloadTableData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (IBAction)toggelScan {
    BlueCapCentralManager* central = [BlueCapCentralManager sharedInstance];
    if (central.isScanning) {
        [central stopScanning];
        [self reloadTableData];
        [self setScanButton];
    } else {
        [central powerOn:^{
            [central disconnectAllPeripherals];
            [central startScanning:^(BlueCapPeripheral* peripheral, NSNumber* RSSI) {
                [peripheral connectAndReconnectOnDisconnect:^(BlueCapPeripheral* connectPeripheral, NSError* error) {
                    [self reloadTableData];
                }];
                [self reloadTableData];
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self setScanButton];
            });
        } afterPowerOff:^{
            [self reloadTableData];
        }];
    }
}

- (void)setScanButton {
    if ([BlueCapCentralManager sharedInstance].isScanning) {
        [self.navigationItem setRightBarButtonItem:self.stopScanBarButtonItem animated:NO];
    } else {
        [self.navigationItem setRightBarButtonItem:self.startScanBarButtonItem animated:NO];
    }
}

- (void)enterForground {
    [self setScanButton];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BlueCapCentralManager* blueCapManager = [BlueCapCentralManager sharedInstance];
    return [blueCapManager.periphreals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"PeripheralCell";
    PeripheralCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    BlueCapPeripheral* peripheral = [[BlueCapCentralManager sharedInstance].periphreals objectAtIndex:indexPath.row];
    [cell.connectingActivityIndicator stopAnimating];
    cell.peripheral = peripheral;
    if (peripheral.state == CBPeripheralStateConnected) {
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.nameLabel.text = peripheral.name;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    BlueCapPeripheral* peripheral = [[BlueCapCentralManager sharedInstance].periphreals objectAtIndex:indexPath.row];
    PeripheralCell* cell = (PeripheralCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell.connectingActivityIndicator startAnimating];
    if (peripheral.state == CBPeripheralStateDisconnected) {
        [peripheral connectAndReconnectOnDisconnect:^(BlueCapPeripheral* __peripheral, NSError* __error) {
            [self reloadTableData];
        }];
    } else {
        [peripheral disconnect:^(BlueCapPeripheral* __peripheral){
            [self reloadTableData];
        }];
    }
}

@end
