//
//  ProfilesViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 10/29/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "ProfilesViewController.h"
#import "ProfileCell.h"

@interface ProfilesViewController ()

@end

@implementation ProfilesViewController

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
    return [[BlueCapCentralManager sharedInstance].serviceProfiles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ProfileCell";
    ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    BlueCapServiceProfile* serviceProfile = [[[BlueCapCentralManager sharedInstance].serviceProfiles allValues] objectAtIndex:indexPath.row];
    cell.nameLabel.text = [serviceProfile name];
    cell.uuidLabel.text = [[serviceProfile UUID] stringValue];
    return cell;
}

@end
