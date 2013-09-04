//
//  CharacteristicDetailViewController.h
//  BlueCapUI
//
//  Created by Troy Stribling on 9/2/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlueCapCharacteristic;

@interface CharacteristicDetailViewController : UITableViewController

@property(nonatomic, retain) BlueCapCharacteristic* characteristic;
@property(nonatomic, retain) IBOutlet UILabel*      uuidLabel;
@property(nonatomic, retain) IBOutlet UILabel*      broadcastingLabel;
@property(nonatomic, retain) IBOutlet UILabel*      notifyingLabel;
@property(nonatomic, retain) IBOutlet UITextField*  valueTextField;
@property(nonatomic, retain) IBOutlet UIButton*     notifiyButton;

@property(nonatomic, retain) IBOutlet UILabel*      propertyBroadcast;
@property(nonatomic, retain) IBOutlet UILabel*      propertyRead;
@property(nonatomic, retain) IBOutlet UILabel*      propertyWriteWithoutResponse;
@property(nonatomic, retain) IBOutlet UILabel*      propertyWrite;
@property(nonatomic, retain) IBOutlet UILabel*      propertyNotify;
@property(nonatomic, retain) IBOutlet UILabel*      propertyIndicate;
@property(nonatomic, retain) IBOutlet UILabel*      propertyAuthenticatedSignedWrites;
@property(nonatomic, retain) IBOutlet UILabel*      propertyExtendedProperties;
@property(nonatomic, retain) IBOutlet UILabel*      propertyNotifyEncryptionRequired;
@property(nonatomic, retain) IBOutlet UILabel*      propertyIndicateEncryptionRequired;

@end
