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
@property(nonatomic, retain) IBOutlet UILabel*      valueLabel;

@end
