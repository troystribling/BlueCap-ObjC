//
//  PeripheralViewController.h
//  BlueCapUI
//
//  Created by Troy Stribling on 8/19/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeripheralViewController : UITableViewController

@property(nonatomic, retain) CBPeripheral*          peripheral;
@property(nonatomic, retain) IBOutlet UILabel*      connectedLabel;
@property(nonatomic, retain) IBOutlet UILabel*      uuidLabel;
@property(nonatomic, retain) IBOutlet UILabel*      rssiLabel;

@end
