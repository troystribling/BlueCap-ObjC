//
//  CharacteristicProfileViewController.m
//  BlueCapUI
//
//  Created by Troy Stribling on 11/7/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "CharacteristicProfileViewController.h"
#import "CharacteristicProfileValuesViewController.h"

@interface CharacteristicProfileViewController ()

- (NSString*)booleanStringValue:(BOOL)__boolValue;
- (NSString*)propertyEnabledStringValue:(CBCharacteristicProperties)__property;
- (NSString*)permissionEnabledStringValue:(CBAttributePermissions)__permission;

@end

@implementation CharacteristicProfileViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.title = self.characteristicProfile.name;
    
    self.uuidLabel.text = [self.characteristicProfile.UUID stringValue];
    
    self.permissionRead.text = [self permissionEnabledStringValue:CBAttributePermissionsReadable];
    self.permissionWrite.text = [self permissionEnabledStringValue:CBAttributePermissionsWriteable];
    self.permissionReadEncryption.text = [self permissionEnabledStringValue:CBAttributePermissionsReadEncryptionRequired];
    self.permissionWriteEncryption.text = [self permissionEnabledStringValue:CBAttributePermissionsWriteEncryptionRequired];
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CharacteristicProfileValues"]) {
        CharacteristicProfileValuesViewController* viewController = segue.destinationViewController;
        viewController.characteristicProfile = self.characteristicProfile;
    }
}

#pragma mark - CharacteristicProfileViewController Private

- (NSString*)booleanStringValue:(BOOL)__boolValue {
    return __boolValue ?  @"YES" : @"NO";
}

- (NSString*)propertyEnabledStringValue:(CBCharacteristicProperties)__property {
    return [self booleanStringValue:[self.characteristicProfile propertyEnabled:__property]];
}

- (NSString*)permissionEnabledStringValue:(CBAttributePermissions)__permission {
    return [self booleanStringValue:[self.characteristicProfile permissionEnabled:__permission]];
}

#pragma mark - Table view data source

#pragma mark - UITableViewDelegate

@end
