//
//  PeripheralServicesViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 8/19/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "PeripheralServicesViewController.h"
#import "CBUUID+StringValue.h"

@interface PeripheralServicesViewController ()

@end

@implementation PeripheralServicesViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    self.peripheral.delegate = self;
    [self.peripheral discoverAllServices];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.peripheral.services count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PeripheralServiceCell" forIndexPath:indexPath];
    BlueCapService* service = [self.peripheral.services objectAtIndex:indexPath.row];
    cell.textLabel.text = service.UUID.stringValue;
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

#pragma mark -
#pragma mark BlueCapPeripheralDelegate

- (void)peripheral:(BlueCapPeripheral*)peripheral didDiscoverServices:(NSError*)error {
    [self.tableView reloadData];
}

- (void)peripheral:(BlueCapPeripheral*)peripheral didDiscoverIncludedServicesForService:(BlueCapService*)service error:(NSError*)error {
    [self.tableView reloadData];
}

@end
