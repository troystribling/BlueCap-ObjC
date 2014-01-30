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

@property(nonatomic, retain) NSMutableArray* serviceProfiles;

- (void)loadServices;


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
    [self loadServices];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)loadServices {
    self.serviceProfiles = [NSMutableArray array];
    for (BlueCapServiceProfile* serviceProfile in [BlueCapProfileManager sharedInstance].services) {
        BOOL serviceAvailable = YES;
        for (BlueCapMutableService * service in [BlueCapPeripheralManager sharedInstance].services) {
            if ([serviceProfile.UUID isEqual:service.UUID]) {
                serviceAvailable = NO;
                break;
            }
        }
        if (serviceAvailable) {
            [self.serviceProfiles addObject:serviceProfile];
        }
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.serviceProfiles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PeripheralManagerServiceProfileCell";
    PeripheralManagerServiceProfileCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    BlueCapServiceProfile* serviceProfile = [self.serviceProfiles objectAtIndex:indexPath.row];
    cell.nameLabel.text = serviceProfile.name;
    cell.uuidLabel.text = [serviceProfile.UUID stringValue];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BlueCapServiceProfile* serviceProfile = [self.serviceProfiles objectAtIndex:indexPath.row];
    BlueCapMutableService* service = [BlueCapMutableService withProfile:serviceProfile];
    [service setCharacteristics:[BlueCapMutableCharacteristic withProfiles:serviceProfile.characteristicProfiles]];
    [[BlueCapPeripheralManager sharedInstance] addService:service
                                         whenCompleteCall:^(BlueCapMutableService* service, NSError* error) {
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 [self.navigationController popViewControllerAnimated:YES];
                                             });
                                         }];
}

@end
