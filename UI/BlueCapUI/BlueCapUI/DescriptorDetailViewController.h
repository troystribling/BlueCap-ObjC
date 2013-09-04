//
//  DescriptorDetailViewController.h
//  BlueCapUI
//
//  Created by Troy Stribling on 9/2/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DescriptorDetailViewController : UITableViewController

@property(nonatomic, retain) BlueCapDescriptor*     descriptor;
@property(nonatomic, retain) IBOutlet UILabel*      uuidLabel;
@property(nonatomic, retain) IBOutlet UILabel*      typeLabel;
@property(nonatomic, retain) IBOutlet UITextField*  valueTextField;

@end
