//
//  PeriphrealsViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "PeriphrealsViewController.h"
#import "PeriphrealViewController.h"

@interface PeriphrealsViewController ()

@end

@implementation PeriphrealsViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [BlueCapCentralManager sharedInstance].delegate = self;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"PeriphrealViewController"]) {
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        PeriphrealViewController *viewController = segue.destinationViewController;
        viewController.periphreal = [[BlueCapCentralManager sharedInstance].periphreals objectAtIndex:selectedRowIndex.row];
    }
}

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
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    CBPeripheral* periphreal = [[BlueCapCentralManager sharedInstance].periphreals objectAtIndex:indexPath.row];
    cell.textLabel.text = periphreal.name;
    return cell;
}

#pragma mark -
#pragma mark UITableViewDataSource

#pragma mark -
#pragma mark BlueCapCentralManagerDelegate

- (void) didRefreshPeriferals {
    [self.tableView reloadData];
}

- (void) didPoweredOff {
}

@end
