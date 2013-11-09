//
//  PeripheralManagerViewController.h
//  BlueCapUI
//
//  Created by Troy Stribling on 11/7/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeripheralManagerViewController : UITableViewController  <UITextFieldDelegate>

@property(nonatomic, retain) IBOutlet UITextField*  nameTextField;
@property(nonatomic, retain) IBOutlet UIButton*     advertiseButton;

@end
