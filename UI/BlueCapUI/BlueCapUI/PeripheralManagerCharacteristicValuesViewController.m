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
#import "PeripheralManagerCharacteristicDiscreteValueViewController.h"
#import "PeripheralManagerCharacteristiceFreeFormValueViewController.h"

@interface PeripheralManagerCharacteristicValuesViewController ()

@property(nonatomic, retain) NSIndexPath*   selectedIndexPath;

- (BOOL)canEdit;

@end

@implementation PeripheralManagerCharacteristicValuesViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.title = self.characteristic.name;
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PeripheralManagerCharacteristicDiscreteValue"]) {
        PeripheralManagerCharacteristicDiscreteValueViewController* viewController = segue.destinationViewController;
        viewController.characteristic = self.characteristic;
    } else if ([segue.identifier isEqualToString:@"PeripheralManagerCharacteristiceFreeFormValue"]) {
        PeripheralManagerCharacteristiceFreeFormValueViewController* viewController = segue.destinationViewController;
        PeripheralManagerCharacteristicValueCell* cell = (PeripheralManagerCharacteristicValueCell*)[self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
        viewController.characteristic = self.characteristic;
        viewController.valueName = cell.nameLabel.text;
    }
}

#pragma mark - Private

- (BOOL)canEdit {
    return ([self.characteristic propertyEnabled:CBCharacteristicPropertyWrite] ||
            [self.characteristic propertyEnabled:CBCharacteristicPropertyWriteWithoutResponse]) &&
            [self.characteristic propertyEnabled:CBCharacteristicPropertyNotify];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    self.selectedIndexPath = indexPath;
    if ([self canEdit]) {
        if ([self.characteristic hasValues]) {
            [self performSegueWithIdentifier:@"PeripheralManagerCharacteristicDiscreteValue" sender:self];
        } else {
            [self performSegueWithIdentifier:@"PeripheralManagerCharacteristiceFreeFormValue" sender:self];
        }
    }
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
    if ([self canEdit]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

@end
