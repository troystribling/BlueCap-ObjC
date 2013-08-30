//
//  PeripheralServicesViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 8/19/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "PeripheralServicesViewController.h"
#import "PeripheralServiceCell.h"
#import "ServiceDetailViewController.h"

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

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ServiceDetail"]) {
        NSIndexPath* serviceIndex = [self.tableView indexPathForCell:sender];
        ServiceDetailViewController* viewController = segue.destinationViewController;
        viewController.service = [self.peripheral.services objectAtIndex:serviceIndex.row];
    }
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
    PeripheralServiceCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PeripheralServiceCell" forIndexPath:indexPath];
    BlueCapService* service = [self.peripheral.services objectAtIndex:indexPath.row];
    cell.uuidLabel.text = service.UUID.stringValue;
    if (service.isPrimary) {
        cell.serviceTypeLabel.text = @"Primary";
    } else {
        cell.serviceTypeLabel.text = @"Secondary";
    }
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
