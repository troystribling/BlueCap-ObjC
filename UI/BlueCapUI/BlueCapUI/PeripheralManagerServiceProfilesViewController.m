//
//  PeripheralManagerServiceProfilesViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 11/9/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "PeripheralManagerServiceProfilesViewController.h"
#import "PeripheralManagerServiceProfileCell.h"

@interface PeripheralManagerServiceProfilesViewController ()

@end

@implementation PeripheralManagerServiceProfilesViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[BlueCapProfileManager sharedInstance].services count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PeripheralManagerServiceProfileCell";
    PeripheralManagerServiceProfileCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    BlueCapServiceProfile* serviceProfile = [[BlueCapProfileManager sharedInstance].services objectAtIndex:indexPath.row];
    cell.nameLabel.text = serviceProfile.name;
    cell.uuidLabel.text = [serviceProfile.UUID stringValue];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BlueCapServiceProfile* serviceProfile = [[BlueCapProfileManager sharedInstance].services objectAtIndex:indexPath.row];
    [[BlueCapPeripheralManager sharedInstance] addService:[BlueCapMutableService withProfile:serviceProfile]
                                         whenCompleteCall:^(BlueCapMutableService* service, NSError* error) {
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 [service setCharacteristics:[BlueCapMutableCharacteristic withProfiles:serviceProfile.characteristicProfiles]];
                                                 [self.navigationController popViewControllerAnimated:YES];
                                             });
                                         }];
}

@end
