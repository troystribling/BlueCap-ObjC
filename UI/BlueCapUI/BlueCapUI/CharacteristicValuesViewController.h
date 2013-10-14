//
//  CharacteristicValuesViewController.h
//  BlueCapUI
//
//  Created by Troy Stribling on 10/2/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharacteristicValuesViewController : UITableViewController

@property(nonatomic, retain) BlueCapCharacteristic*     characteristic;
@property(nonatomic, retain) IBOutlet UIBarButtonItem   *refreshutton;

@end
