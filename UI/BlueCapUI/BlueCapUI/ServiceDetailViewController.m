//
//  ServiceDetailViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 8/28/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "ServiceDetailViewController.h"

@interface ServiceDetailViewController ()

@end

@implementation ServiceDetailViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.service discoverAllCharacteritics];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
}

#pragma mark -
#pragma mark UITableDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.service.characteristics count];
}

- (UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    static NSString *CellIdentifier = @"ServiceDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"characteristic-%d", indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

#pragma mark -
#pragma mark BlueCapSErviceDelegate

- (void)didDiscoverCharacteristicsForService:(BlueCapService*)service error:(NSError*)error {
}

- (void)didDiscoverDescriptorsForCharacteristic:(BlueCapCharacteristic*)characteristic error:(NSError*)error {
}

@end
