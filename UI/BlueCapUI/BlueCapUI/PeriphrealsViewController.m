//
//  PeriphrealsViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 8/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "PeriphrealsViewController.h"

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
    [BlueCapManager sharedInstance].blueCapManagerDelegate = self;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BlueCapManager* blueCapManager = [BlueCapManager sharedInstance];
    return [blueCapManager.foundPeriphreals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"PeripheralCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    CBPeripheral* periphreal = [[BlueCapManager sharedInstance].foundPeriphreals objectAtIndex:indexPath.row];
    cell.textLabel.text = periphreal.name;
    return cell;
}

#pragma mark -
#pragma mark BlueCapManagerDelegate

- (void) didRefreshPeriferals {
    [self.tableView reloadData];
}

- (void) didPoweredOff {
}

@end
