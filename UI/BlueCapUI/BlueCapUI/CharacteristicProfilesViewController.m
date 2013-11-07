//
//  CharacteristicProfilesViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 10/30/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "CharacteristicProfilesViewController.h"
#import "CharacteristicProfileValuesViewController.h"
#import "CharacteristicProfileCell.h"

@interface CharacteristicProfilesViewController ()

@end

@implementation CharacteristicProfilesViewController

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CharacteristicProfileValues"]) {
        NSIndexPath* indexPath = [self.tableView indexPathForCell:sender];
        BlueCapCharacteristicProfile* characteristicProfile = [self.serviceProfile.characteristicProfiles objectAtIndex:indexPath.row];
        CharacteristicProfileValuesViewController* viewController = segue.destinationViewController;
        viewController.characteristicProfile = characteristicProfile;
    }
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    BOOL shouldSegue = NO;
    NSIndexPath* indexPath = [self.tableView indexPathForCell:sender];
    BlueCapCharacteristicProfile* characteristicProfile = [self.serviceProfile.characteristicProfiles objectAtIndex:indexPath.row];
    if ([characteristicProfile hasValues]) {
        shouldSegue = YES;
    }
    return shouldSegue;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.serviceProfile.characteristicProfiles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CharacteristicProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CharacteristicProfileCell" forIndexPath:indexPath];
    BlueCapCharacteristicProfile* characteristicProfile = [self.serviceProfile.characteristicProfiles objectAtIndex:indexPath.row];
    cell.nameLabel.text = characteristicProfile.name;
    cell.uuidLabel.text = [characteristicProfile.UUID stringValue];
    return cell;
}

@end
