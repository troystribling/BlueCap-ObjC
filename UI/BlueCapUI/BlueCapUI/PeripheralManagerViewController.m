//
//  PeripheralManagerViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 11/7/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "PeripheralManagerViewController.h"

@interface PeripheralManagerViewController ()

- (IBAction)toggleAdvertise:(id)sender;
- (void)setAdvertiseButtonLabel;

@end

@implementation PeripheralManagerViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self setAdvertiseButtonLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PeripheralManagerServices"]) {
    }
}

#pragma mark - Private

- (IBAction)toggleAdvertise:(id)sender {
    BlueCapPeripheralManager* manager = [BlueCapPeripheralManager sharedInstance];
    if ([manager isAdvertising]) {
        [manager stopAdvertising:^(BlueCapPeripheralManager* peripheralManager) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setAdvertiseButtonLabel];
            });
        }];
    } else {
        [manager startAdvertising:self.nameTextField.text afterStart:^(BlueCapPeripheralManager* perpheralManager) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setAdvertiseButtonLabel];
            });
        }];
    }
}

- (void)setAdvertiseButtonLabel {
    if (self.nameTextField.text == nil || [[BlueCapPeripheralManager sharedInstance].services count] == 0) {
        [self.advertiseButton setTitleColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0] forState:UIControlStateDisabled];
        self.advertiseButton.enabled = NO;
    } else {
        self.advertiseButton.enabled = YES;
        if ([BlueCapPeripheralManager sharedInstance].isAdvertising) {
            [self.advertiseButton setTitle:@"Start Advertising" forState:UIControlStateNormal];
            [self.advertiseButton setTitleColor:[UIColor colorWithRed:0.1 green:0.7 blue:0.1 alpha:1.0] forState:UIControlStateNormal];
        } else {
            [self.advertiseButton setTitle:@"Stop Advertising" forState:UIControlStateNormal];
            [self.advertiseButton setTitleColor:[UIColor colorWithRed:0.7 green:0.1 blue:0.1 alpha:1.0] forState:UIControlStateNormal];
        }
    }
}

#pragma mark - Table view data source

#pragma mark - UITableViewDelegate

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    [self.nameTextField resignFirstResponder];
    [self setAdvertiseButtonLabel];
    return YES;
}

@end
