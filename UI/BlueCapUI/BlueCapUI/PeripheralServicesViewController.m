//
//  PeripheralServicesViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 8/19/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "PeripheralServicesViewController.h"
#import "PeripheralServiceCell.h"
#import "ServiceViewController.h"

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
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.peripheral discoverAllServices:^(NSArray* __services) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"Service"]) {
        NSIndexPath* serviceIndex = [self.tableView indexPathForCell:sender];
        ServiceViewController* viewController = segue.destinationViewController;
        viewController.service = [self.peripheral.services objectAtIndex:serviceIndex.row];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.peripheral.services count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PeripheralServiceCell* cell = [tableView dequeueReusableCellWithIdentifier:@"PeripheralServiceCell" forIndexPath:indexPath];
    BlueCapService* service = [self.peripheral.services objectAtIndex:indexPath.row];
    if ([service hasProfile]) {
        cell.nameLabel.text = service.profile.name;
    } else {
        cell.nameLabel.text = service.UUID.stringValue;
    }
    if (service.isPrimary) {
        cell.serviceTypeLabel.text = @"Primary";
    } else {
        cell.serviceTypeLabel.text = @"Secondary";
    }
    return cell;
}

#pragma mark - UITableViewDelegate

@end
