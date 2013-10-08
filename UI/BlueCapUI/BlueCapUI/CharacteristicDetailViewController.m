//
//  ChracteristicDetailViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 9/2/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "CharacteristicDetailViewController.h"
#import "CharacteristicDescriptorsViewController.h"

@interface CharacteristicDetailViewController ()

- (NSString*)booleanStringValue:(BOOL)__boolValue;
- (NSString*)propertyEnabledStringValue:(CBCharacteristicProperties)__property;

@end

@implementation CharacteristicDetailViewController

#pragma mark -
#pragma mark ChracteristicDetailViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
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
    if (self.characteristic.isNotifying) {
        [self.notifiyButton setTitle:@"Stop Notifications" forState:UIControlStateNormal];
        [self.notifiyButton setTitleColor:[UIColor colorWithRed:0.7 green:0.1 blue:0.1 alpha:1.0] forState:UIControlStateNormal];
    } else {
        [self.notifiyButton setTitle:@"Start Notifications" forState:UIControlStateNormal];
        [self.notifiyButton setTitleColor:[UIColor colorWithRed:0.1 green:0.7 blue:0.1 alpha:1.0] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CharacteristicDescriptors"]) {
        CharacteristicDescriptorsViewController* viewController = segue.destinationViewController;
        viewController.characteristic = self.characteristic;
    }
}

#pragma mark -
#pragma mark ChracteristicDetailViewController Friend API

- (NSString*)booleanStringValue:(BOOL)__boolValue {
    return __boolValue ?  @"YES" : @"NO";
}

- (NSString*)propertyEnabledStringValue:(CBCharacteristicProperties)__property {
    return [self booleanStringValue:[self.characteristic propertyEnabled:__property]];
}

@end
