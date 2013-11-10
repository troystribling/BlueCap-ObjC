//
//  ServiceProfilesViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 10/29/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "ServiceProfilesViewController.h"
#import "CharacteristicProfilesViewController.h"
#import "ServiceProfileCell.h"

@interface ServiceProfilesViewController ()

@end

@implementation ServiceProfilesViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CharacteristicProfiles"]) {
        NSIndexPath* indexPath = [self.tableView indexPathForCell:sender];
        CharacteristicProfilesViewController* viewController = segue.destinationViewController;
        viewController.serviceProfile = [[BlueCapProfileManager sharedInstance].services objectAtIndex:indexPath.row];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[BlueCapProfileManager sharedInstance].services count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ServiceProfileCell";
    ServiceProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    BlueCapServiceProfile* serviceProfile = [[BlueCapProfileManager sharedInstance].services objectAtIndex:indexPath.row];
    cell.nameLabel.text = [serviceProfile name];
    cell.uuidLabel.text = [[serviceProfile UUID] stringValue];
    return cell;
}

@end
