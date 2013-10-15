//
//  CharacteristicValueViewController.h
//  BlueCapUI
//
//  Created by Troy Stribling on 10/13/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharacteristicValueViewController : UIViewController

@property(nonatomic, retain) IBOutlet UITextField*      valueTextField;
@property(nonatomic, retain) BlueCapCharacteristic*     characteristic;

@end
