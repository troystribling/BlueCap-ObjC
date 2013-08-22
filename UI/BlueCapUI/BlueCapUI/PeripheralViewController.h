//
//  PeripheralViewController.h
//  BlueCapUI
//
//  Created by Troy Stribling on 8/19/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeripheralViewController : UITableViewController

@property(nonatomic, retain) CBPeripheral*                  peripheral;
@property(nonatomic, retain) IBOutlet UIButton*             connectButton;
@property(nonatomic, retain) IBOutlet UITextField*          uuidTextField;
@property(nonatomic, retain) IBOutlet UITextField*          rssiTextField;

@end
