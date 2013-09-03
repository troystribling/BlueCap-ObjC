//
//  ServiceDetailViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 8/28/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "ServiceDetailViewController.h"
#import "CharacteristicDetailViewController.h"

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
    self.service.delegate = self;
    [self.service discoverAllCharacteritics];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CharacteristicDetail"]) {
        NSIndexPath* selectedIndexPath = [self.tableView indexPathForCell:sender];
        CharacteristicDetailViewController* viewController = segue.destinationViewController;
        BlueCapCharacteristic* characteristic = [self.service.characteristics objectAtIndex:selectedIndexPath.row];
        viewController.characteristic = characteristic;
    }
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
    BlueCapCharacteristic* characteristic = [self.service.characteristics objectAtIndex:indexPath.row];
    cell.textLabel.text = characteristic.UUID.stringValue;
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

#pragma mark -
#pragma mark BlueCapServiceDelegate

- (void)didDiscoverCharacteristicsForService:(BlueCapService*)service error:(NSError*)error {
    [self.tableView reloadData];
}

- (void)didDiscoverDescriptorsForCharacteristic:(BlueCapCharacteristic*)characteristic error:(NSError*)error {
}

- (void)didDiscoverIncludedServicesForService:(BlueCapService*)service error:(NSError*)error {
}

@end
