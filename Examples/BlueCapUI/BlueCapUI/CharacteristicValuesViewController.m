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

@interface CharacteristicValuesViewController ()

@property(nonatomic, retain) ProgressView*  progressView;
@property(nonatomic, retain) NSDictionary*  values;

- (IBAction)refeshValues;
- (void)readData;
- (void)loadData:(NSDictionary*)__data;
- (void)error:(NSError*)__error;
- (BOOL)canEdit;

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
        NSIndexPath* selectedIndexPath = [self.tableView indexPathForCell:sender];
        NSArray* valueNames = [self.values allKeys];
        CharacteristicFreeFormValueViewController* viewController = segue.destinationViewController;
        viewController.valueName = [valueNames objectAtIndex:selectedIndexPath.row];
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
}

- (void)readData {
    if ([self.characteristic propertyEnabled:CBCharacteristicPropertyRead]) {
        [self.characteristic readData:^(BlueCapCharacteristic* __characteristic, NSError* __error) {
            if (__error) {
                [self error:__error];
            } else {
                [self loadData:[__characteristic stringValue]];
            }
        }];
    } else {
        self.values = [self.characteristic stringValue];
        [self.tableView reloadData];
    }
    if (self.characteristic.isNotifying) {
        self.refreshButton.enabled = NO;
        [self.characteristic receiveUpdates:^(BlueCapCharacteristic* __characteristic, NSError* __error) {
            if (__error) {
                [self error:__error];
            } else {
                [self loadData:[__characteristic stringValue]];
            }
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

- (void)error:(NSError*)__error {
    dispatch_sync(dispatch_get_main_queue(), ^{
        [UIAlertView alertOnError:__error];
        [self.progressView remove];
    });
}

- (BOOL)canEdit {
    return [self.characteristic propertyEnabled:CBCharacteristicPropertyWrite] || [self.characteristic propertyEnabled:CBCharacteristicPropertyWriteWithoutResponse];
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
