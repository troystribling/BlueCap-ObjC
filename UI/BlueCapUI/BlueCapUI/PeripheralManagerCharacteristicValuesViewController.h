//
//  PeripheralManagerCharacteristicValuesViewController.h
//  BlueCapUI
//
//  Created by Troy Stribling on 11/17/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlueCapMutableCharacteristic;

@interface PeripheralManagerCharacteristicValuesViewController : UITableViewController

@property(nonatomic, retain) BlueCapMutableCharacteristic* characteristic;

@end
