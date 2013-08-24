//
//  PeripheralServicesViewController.h
//  BlueCapUI
//
//  Created by Troy Stribling on 8/19/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeripheralServicesViewController : UITableViewController <CBPeripheralDelegate>

@property(nonatomic, retain) CBPeripheral*  peripheral;

@end
