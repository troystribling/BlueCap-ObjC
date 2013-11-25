//
//  CharacteristicValuesViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 10/2/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "CharacteristicValuesViewController.h"
#import "CharacteristicValueCell.h"
#import "CharacteristicFreeFormValueViewController.h"
#import "CharacteristicDiscreteValueViewController.h"
#import "ProgressView.h"
#import "UIAlertView+Extensions.h"

#define CHARACTERISTIC_UPDATE_TIMEOUT   10.0

@interface CharacteristicValuesViewController ()

@property(nonatomic, retain) ProgressView*  progressView;
@property(nonatomic, retain) NSDictionary*  values;

- (IBAction)refeshValues;
- (void)readData;
- (void)loadData:(NSDictionary*)__data;
- (BOOL)canEdit;
- (void)timeoutUpdate;

@end

@implementation CharacteristicValuesViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.title = self.characteristic.profile.name;
    self.progressView = [ProgressView progressView];
    self.values = [NSDictionary dictionary];
}

- (void)viewWillAppear:(BOOL)animated {
    [self refeshValues];
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
    if ([[segue identifier] isEqualToString:@"CharacteristicFreeFormValue"]) {
        CharacteristicValuesViewController* viewController = segue.destinationViewController;
        viewController.characteristic = self.characteristic;
    } else if ([[segue identifier] isEqualToString:@"CharacteristicDiscreteValue"]) {
        CharacteristicDiscreteValueViewController* viewController = segue.destinationViewController;
        viewController.characteristic = self.characteristic;
    }
}

#pragma mark - Private

- (IBAction)refeshValues {
    [self.progressView progressWithMessage:@"Updating" inView:[[UIApplication sharedApplication] keyWindow]];
    [self readData];
    [self timeoutUpdate];
}

- (void)readData {
    if ([self.characteristic propertyEnabled:CBCharacteristicPropertyRead]) {
        [self.characteristic readData:^(BlueCapCharacteristic* __characteristic, NSError* __error) {
            [self loadData:[__characteristic stringValue]];
        }];
    } else {
        self.values = [self.characteristic stringValue];
        [self.tableView reloadData];
    }
    if (self.characteristic.isNotifying) {
        self.refreshButton.enabled = NO;
        [self.characteristic receiveUpdates:^(BlueCapCharacteristic* __characteristic, NSError* __error) {
            [self loadData:[__characteristic stringValue]];
        }];
    } else {
        self.refreshButton.enabled = YES;
    }
}

- (void)loadData:(NSDictionary*)__data {
    dispatch_sync(dispatch_get_main_queue(), ^{
        self.values = __data;
        [self.progressView remove];
        [self.tableView reloadData];
    });
}

- (BOOL)canEdit {
    return [self.characteristic propertyEnabled:CBCharacteristicPropertyWrite] || [self.characteristic propertyEnabled:CBCharacteristicPropertyWriteWithoutResponse];
}

- (void)timeoutUpdate {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CHARACTERISTIC_UPDATE_TIMEOUT * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        [self.progressView remove];
        [self.tableView reloadData];
        [UIAlertView showMessage:@"Update Timeout"];
    });
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    if ([self canEdit]) {
        if ([self.characteristic hasValues]) {
            [self performSegueWithIdentifier:@"CharacteristicDiscreteValue" sender:self];
        } else {
            [self performSegueWithIdentifier:@"CharacteristicFreeFormValue" sender:self];
        }
    }
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
    if ([self canEdit]) {
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
