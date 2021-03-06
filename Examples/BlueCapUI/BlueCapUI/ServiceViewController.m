//
//  ServiceViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 8/28/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "ServiceViewController.h"
#import "CharacteristicViewController.h"
#import "CharacteristicCell.h"

@interface ServiceViewController ()

@end

@implementation ServiceViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.service discoverAllCharacteritics:^(NSArray* __discoveredCharacteristics) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Characteristic"]) {
        NSIndexPath* selectedIndexPath = [self.tableView indexPathForCell:sender];
        CharacteristicViewController* viewController = segue.destinationViewController;
        BlueCapCharacteristic* characteristic = [self.service.characteristics objectAtIndex:selectedIndexPath.row];
        viewController.characteristic = characteristic;
    }
}

#pragma mark - UITableDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.service.characteristics count];
}

- (UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    CharacteristicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CharacteristicCell" forIndexPath:indexPath];
    BlueCapCharacteristic* characteristic = [self.service.characteristics objectAtIndex:indexPath.row];
    cell.nameLabel.text = characteristic.name;
    cell.uuidLabel.text = [characteristic.UUID stringValue];
    return cell;
}

#pragma mark - UITableViewDelegate

@end
