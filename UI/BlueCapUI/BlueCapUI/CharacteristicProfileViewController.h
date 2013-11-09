//
//  CharacteristicProfileViewController.h
//  BlueCapUI
//
//  Created by Troy Stribling on 11/7/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlueCapCharacteristicProfile;

@interface CharacteristicProfileViewController : UITableViewController

@property(nonatomic, retain) BlueCapCharacteristicProfile*  characteristicProfile;

@property(nonatomic, retain) IBOutlet UILabel*              permissionRead;
@property(nonatomic, retain) IBOutlet UILabel*              permissionWrite;
@property(nonatomic, retain) IBOutlet UILabel*              permissionReadEncryption;
@property(nonatomic, retain) IBOutlet UILabel*              permissionWriteEncryption;

@property(nonatomic, retain) IBOutlet UILabel*              propertyBroadcast;
@property(nonatomic, retain) IBOutlet UILabel*              propertyRead;
@property(nonatomic, retain) IBOutlet UILabel*              propertyWriteWithoutResponse;
@property(nonatomic, retain) IBOutlet UILabel*              propertyWrite;
@property(nonatomic, retain) IBOutlet UILabel*              propertyNotify;
@property(nonatomic, retain) IBOutlet UILabel*              propertyIndicate;
@property(nonatomic, retain) IBOutlet UILabel*              propertyAuthenticatedSignedWrites;
@property(nonatomic, retain) IBOutlet UILabel*              propertyExtendedProperties;
@property(nonatomic, retain) IBOutlet UILabel*              propertyNotifyEncryptionRequired;
@property(nonatomic, retain) IBOutlet UILabel*              propertyIndicateEncryptionRequired;

@end
