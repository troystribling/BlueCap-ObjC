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
    if ([segue.identifier isEqualToString:@"CharacteristicDetail"]) {
        NSIndexPath* selectedIndexPath = [self.tableView indexPathForCell:sender];
        CharacteristicDetailViewController* viewController = segue.destinationViewController;
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
    static NSString *CellIdentifier = @"ServiceDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    BlueCapCharacteristic* characteristic = [self.service.characteristics objectAtIndex:indexPath.row];
    if ([characteristic hasProfile]) {
        cell.textLabel.text = characteristic.profile.name;
    } else {
        cell.textLabel.text = characteristic.UUID.stringValue;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

@end
