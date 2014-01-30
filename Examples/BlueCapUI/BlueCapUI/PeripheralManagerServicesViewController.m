//
//  PeripheralManagerServicesViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 11/9/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "PeripheralManagerServicesViewController.h"
#import "PeripheralManagerServiceProfilesViewController.h"
#import "PeripheralManagerCharacteristicsViewController.h"
#import "PeripheralManagerServiceCell.h"

@interface PeripheralManagerServicesViewController ()

@end

@implementation PeripheralManagerServicesViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.addServiceButton.enabled = ![BlueCapPeripheralManager sharedInstance].isAdvertising;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PeripheralManagerCharacteristics"]) {
        NSIndexPath* indexPath = [self.tableView indexPathForCell:sender];
        BlueCapMutableService* service = [[BlueCapPeripheralManager sharedInstance].services objectAtIndex:indexPath.row];
        PeripheralManagerCharacteristicsViewController* viewController = segue.destinationViewController;
        viewController.service = service;
    } else if ([segue.identifier isEqualToString:@"PeripheralManagerServiceProfiles"]) {
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[BlueCapPeripheralManager sharedInstance].services count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PeripheralManagerServicesViewControllerCell";
    PeripheralManagerServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    BlueCapMutableService* service = [[BlueCapPeripheralManager sharedInstance].services objectAtIndex:indexPath.row];
    cell.nameLabel.text = service.name;
    cell.uuidLabel.text = [service.UUID stringValue];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([BlueCapPeripheralManager sharedInstance].isAdvertising) {
        return NO;
    } else {
        return YES;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BlueCapMutableService* service = [[BlueCapPeripheralManager sharedInstance].services objectAtIndex:indexPath.row];
        [[BlueCapPeripheralManager sharedInstance] removeService:service afterRemoved:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            });
        }];
    }
}

@end
