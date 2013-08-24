//
//  PeriphrealsViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "PeripheralsViewController.h"
#import "PeripheralViewController.h"
#import "PeripheralCell.h"

@interface PeripheralsViewController () {
    NSIndexPath* selectedIndexPath;
}

@end

@implementation PeripheralsViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [BlueCapCentralManager sharedInstance].delegate = self;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"PeripheralViewController"]) {
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        PeripheralViewController *viewController = segue.destinationViewController;
        viewController.peripheral = [[BlueCapCentralManager sharedInstance].periphreals objectAtIndex:selectedRowIndex.row];
    }
}

#pragma mark -
#pragma mark PeripheralsViewController PrivateAPI

#pragma mark -
#pragma mark UITableViewDataSource

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
    if (cell == nil) {
        cell = [[PeripheralCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    CBPeripheral* periphreal = [[BlueCapCentralManager sharedInstance].periphreals objectAtIndex:indexPath.row];
    cell.nameLabel.text = periphreal.name;
    cell.connectionStatusImage.hidden = periphreal.state == CBPeripheralStateDisconnected;
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    selectedIndexPath = indexPath;
    CBPeripheral* peripheral = [[BlueCapCentralManager sharedInstance].periphreals objectAtIndex:indexPath.row];
    PeripheralCell* cell = (PeripheralCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (peripheral.state == CBPeripheralStateDisconnected) {
        [[BlueCapCentralManager sharedInstance] connectPeripherial:peripheral];
    } else {
        [[BlueCapCentralManager sharedInstance] disconnectPeripheral:peripheral];
        cell.connectionStatusImage.hidden = YES;
    }
    [cell.connectingActivityIndicator startAnimating];
}

#pragma mark -
#pragma mark BlueCapCentralManagerDelegate

- (void)didRefreshPeriferals {
    [self.tableView reloadData];
}

- (void)didPoweredOff {
}

- (void)didConnectPeripheral:(CBPeripheral*)peripheral {
    PeripheralCell* cell = (PeripheralCell*)[self.tableView cellForRowAtIndexPath:selectedIndexPath];
    [cell.connectingActivityIndicator stopAnimating];
    cell.connectionStatusImage.hidden = NO;
}

- (void)didDisconnectPeripheral:(CBPeripheral*)peripheral {
    PeripheralCell* cell = (PeripheralCell*)[self.tableView cellForRowAtIndexPath:selectedIndexPath];
    [cell.connectingActivityIndicator stopAnimating];
}

@end
