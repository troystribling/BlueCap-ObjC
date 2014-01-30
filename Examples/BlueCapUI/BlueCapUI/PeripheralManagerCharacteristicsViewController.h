//
//  PeripheralManagerCharacteristicsViewController.h
//  BlueCapUI
//
//  Created by Troy Stribling on 11/10/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlueCapMutableService;

@interface PeripheralManagerCharacteristicsViewController : UITableViewController

@property(nonatomic, retain) BlueCapMutableService* service;

@end
