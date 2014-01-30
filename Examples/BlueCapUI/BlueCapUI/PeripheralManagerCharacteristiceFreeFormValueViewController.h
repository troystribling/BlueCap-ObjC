//
//  PeripheralManagerCharacteristiceFreeFormValueViewController.h
//  BlueCapUI
//
//  Created by Troy Stribling on 11/10/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlueCapMutableCharacteristic;

@interface PeripheralManagerCharacteristiceFreeFormValueViewController : UIViewController <UITextFieldDelegate>

@property(nonatomic, retain) IBOutlet UITextField*          valueTextField;
@property(nonatomic, retain) BlueCapMutableCharacteristic*  characteristic;
@property(nonatomic, retain) NSString*                      valueName;

@end
