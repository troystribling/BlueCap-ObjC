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
}

@end

@implementation PeripheralsViewController

#pragma mark -
#pragma mark PeripheralsViewController

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
    if ([[segue identifier] isEqualToString:@"Peripheral"]) {
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForCell:sender];
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
    CBPeripheral* peripheral = [[BlueCapCentralManager sharedInstance].periphreals objectAtIndex:indexPath.row];
    [cell.connectingActivityIndicator stopAnimating];
    if (peripheral.state == CBPeripheralStateDisconnected) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    cell.nameLabel.text = peripheral.name;
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    BlueCapPeripheral* peripheral = [[BlueCapCentralManager sharedInstance].periphreals objectAtIndex:indexPath.row];
    PeripheralCell* cell = (PeripheralCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell.connectingActivityIndicator startAnimating];
    if (peripheral.state == CBPeripheralStateDisconnected) {
        [peripheral connect];
    } else {
        [peripheral disconnect];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath*)indexPath {
}

#pragma mark -
#pragma mark BlueCapCentralManagerDelegate


- (void)didPoweredOff {
    [self.tableView reloadData];
}

- (void)didDiscoverPeripheral:(BlueCapPeripheral *)peripheral {
    [self.tableView reloadData];
}

- (void)didConnectPeripheral:(CBPeripheral*)peripheral {
    [self.tableView reloadData];
}

- (void)didDisconnectPeripheral:(CBPeripheral*)peripheral {
    [self.tableView reloadData];
}

@end
