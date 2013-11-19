//
//  PeripheralManagerCharacteristicValuesViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 11/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "PeripheralManagerCharacteristicValuesViewController.h"
#import "PeripheralManagerCharacteristicValueCell.h"

@interface PeripheralManagerCharacteristicValuesViewController ()

@end

@implementation PeripheralManagerCharacteristicValuesViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
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
    return[[self.characteristic stringValue] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PeripheralManagerCharacteristicValue";
    PeripheralManagerCharacteristicValueCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary* values = [self.characteristic stringValue];
    NSString* valueName = [[values allKeys] objectAtIndex:indexPath.row];
    cell.nameLabel.text = valueName;
    cell.valuelabel.text = [values objectForKey:valueName];
    return cell;
}

@end
