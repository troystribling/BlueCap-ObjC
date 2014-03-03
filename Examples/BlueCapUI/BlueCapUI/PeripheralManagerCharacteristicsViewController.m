//
//  PeripheralManagerCharacteristicsViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 11/10/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "PeripheralManagerCharacteristicsViewController.h"
#import "PeripheralManagerCharacteristicViewController.h"
#import "PeripheralManagerCharacteristicCell.h"

@interface PeripheralManagerCharacteristicsViewController ()

@end

@implementation PeripheralManagerCharacteristicsViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.title = self.service.name;
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PeripheralManagerCharacteristic"]) {
        NSIndexPath* indexPath = [self.tableView indexPathForCell:sender];
        BlueCapMutableCharacteristic* characteristic = [self.service.characteristics objectAtIndex:indexPath.row];
        PeripheralManagerCharacteristicViewController* viewController = segue.destinationViewController;
        viewController.characteristic = characteristic;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"COUNT: %ld", [self.service.characteristics count]);
    return [self.service.characteristics count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PeripheralManagerCharacteristicCell";
    PeripheralManagerCharacteristicCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    BlueCapMutableCharacteristic* characteristic = [self.service.characteristics objectAtIndex:indexPath.row];
    cell.nameLabel.text = characteristic.name;
    cell.uuidLabel.text = [characteristic.UUID stringValue];
    return cell;
}

@end
