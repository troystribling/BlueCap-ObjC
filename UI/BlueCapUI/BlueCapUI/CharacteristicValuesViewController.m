//
//  CharacteristicValuesViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 10/2/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "CharacteristicValuesViewController.h"
#import "CharacteristicValueCell.h"
#import "CharacteristicValueViewController.h"

@interface CharacteristicValuesViewController ()

@property(nonatomic, retain) NSDictionary* values;

- (IBAction)refeshValues:(id)sender;
- (void)readData;
- (void)loadData:(NSDictionary*)__data;

@end

@implementation CharacteristicValuesViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    self.values = [NSDictionary dictionary];
    [self readData];
}

- (void)viewWillAppear:(BOOL)animated {
    [self readData];
}

- (void)viewWillDisappear:(BOOL)animated {
    if (self.characteristic.isNotifying) {
        [self.characteristic dropUpdates];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"CharacteristicValue"]) {
        CharacteristicValuesViewController *viewController = segue.destinationViewController;
        viewController.characteristic = self.characteristic;
    }
}

#pragma mark -
#pragma mark Private

- (IBAction)refeshValues:(id)sender {
    [self readData];
}

- (void)readData {
    if (self.characteristic.isNotifying) {
        self.refreshButton.enabled = NO;
        [self.characteristic receiveUpdates:^(BlueCapCharacteristicData* __data, NSError* __error) {
            [self loadData:[__data stringValue]];
        }];
    } else {
        self.refreshButton.enabled = YES;
        [self.characteristic readData:^(BlueCapCharacteristicData* __data, NSError* __error) {
            [self loadData:[__data stringValue]];
        }];
    }
}

- (void)loadData:(NSDictionary*)__data {
    dispatch_sync(dispatch_get_main_queue(), ^{
        self.values = __data;
        [self.tableView reloadData];
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.values count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CharacteristicValueCell";
    CharacteristicValueCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSArray* valueNames = [self.values allKeys];
    if ([self.characteristic propertyEnabled:CBCharacteristicPropertyWrite] ||
        [self.characteristic propertyEnabled:CBCharacteristicPropertyWriteWithoutResponse]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    NSString* valueName = [valueNames objectAtIndex:indexPath.row];
    cell.valueNameLable.text = valueName;
    cell.valueLable.text = [self.values objectForKey:valueName];
    return cell;
}

@end
