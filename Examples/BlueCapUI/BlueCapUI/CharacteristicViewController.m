//
//  CharacteristicViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 9/2/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "CharacteristicViewController.h"
#import "CharacteristicDescriptorsViewController.h"
#import "CharacteristicValuesViewController.h"

@interface CharacteristicViewController ()

- (NSString*)booleanStringValue:(BOOL)__boolValue;
- (NSString*)propertyEnabledStringValue:(CBCharacteristicProperties)__property;
- (IBAction)toggleNotifications;
- (void)setNotifiyButtonLabel;

@end

@implementation CharacteristicViewController

#pragma mark - CharacteristicViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    if ([self.characteristic hasProfile]) {
        self.navigationItem.title = self.characteristic.profile.name;
    } else {
        self.navigationItem.title = [[[self.characteristic.UUID stringValue] componentsSeparatedByString:@"-"] objectAtIndex:0];
    }
    self.uuidLabel.text = self.characteristic.UUID.stringValue;
    self.broadcastingLabel.text = [self booleanStringValue:self.characteristic.isBroadcasted];
    self.notifyingLabel.text = [self booleanStringValue:self.characteristic.isNotifying];
    self.propertyBroadcast.text = [self propertyEnabledStringValue:CBCharacteristicPropertyBroadcast];
    self.propertyRead.text = [self propertyEnabledStringValue:CBCharacteristicPropertyRead];
    self.propertyWriteWithoutResponse.text = [self propertyEnabledStringValue:CBCharacteristicPropertyWriteWithoutResponse];
    self.propertyWrite.text = [self propertyEnabledStringValue:CBCharacteristicPropertyWrite];
    self.propertyNotify.text = [self propertyEnabledStringValue:CBCharacteristicPropertyNotify];
    self.propertyIndicate.text = [self propertyEnabledStringValue:CBCharacteristicPropertyIndicate];
    self.propertyAuthenticatedSignedWrites.text = [self propertyEnabledStringValue:CBCharacteristicPropertyAuthenticatedSignedWrites];
    self.propertyExtendedProperties.text = [self propertyEnabledStringValue:CBCharacteristicPropertyExtendedProperties];
    self.propertyNotifyEncryptionRequired.text = [self propertyEnabledStringValue:CBCharacteristicPropertyNotifyEncryptionRequired];
    self.propertyIndicateEncryptionRequired.text = [self propertyEnabledStringValue:CBCharacteristicPropertyIndicateEncryptionRequired];
    if ([self.characteristic propertyEnabled:CBCharacteristicPropertyNotify]) {
        self.notifiyButton.enabled = YES;
        [self setNotifiyButtonLabel];
    } else {
        [self.notifiyButton setTitleColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0] forState:UIControlStateDisabled];
        self.notifiyButton.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CharacteristicDescriptors"]) {
        CharacteristicDescriptorsViewController* viewController = segue.destinationViewController;
        viewController.characteristic = self.characteristic;
    } else if ([segue.identifier isEqualToString:@"CharacteristicValues"]) {
        CharacteristicValuesViewController* viewController = segue.destinationViewController;
        viewController.characteristic = self.characteristic;
    }
}

#pragma mark - Private

- (IBAction)toggleNotifications {
    [self.notifiyButton setTitleColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0] forState:UIControlStateNormal];
    self.notifiyButton.enabled = NO;
    if (self.characteristic.isNotifying) {
        [self.notifiyButton setTitle:@"Unsubscribing" forState:UIControlStateNormal];
        [self.characteristic stopNotifications:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setNotifiyButtonLabel];
                self.notifyingLabel.text = [self booleanStringValue:self.characteristic.isNotifying];
            });
        }];
    } else {
        [self.notifiyButton setTitle:@"Subscribing" forState:UIControlStateNormal];
        [self.characteristic startNotifications:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setNotifiyButtonLabel];
                self.notifyingLabel.text = [self booleanStringValue:self.characteristic.isNotifying];
            });
        }];
    }
}

- (void)setNotifiyButtonLabel {
    self.notifiyButton.enabled = YES;
    if (self.characteristic.isNotifying) {
        [self.notifiyButton setTitle:@"Stop Notifications" forState:UIControlStateNormal];
        [self.notifiyButton setTitleColor:[UIColor colorWithRed:0.7 green:0.1 blue:0.1 alpha:1.0] forState:UIControlStateNormal];
    } else {
        [self.notifiyButton setTitle:@"Start Notifications" forState:UIControlStateNormal];
        [self.notifiyButton setTitleColor:[UIColor colorWithRed:0.1 green:0.7 blue:0.1 alpha:1.0] forState:UIControlStateNormal];
    }
}

#pragma mark - ChracteristicDetailViewController Friend API

- (NSString*)booleanStringValue:(BOOL)__boolValue {
    return __boolValue ?  @"YES" : @"NO";
}

- (NSString*)propertyEnabledStringValue:(CBCharacteristicProperties)__property {
    return [self booleanStringValue:[self.characteristic propertyEnabled:__property]];
}

#pragma mark - UITableViewDelegate

@end
