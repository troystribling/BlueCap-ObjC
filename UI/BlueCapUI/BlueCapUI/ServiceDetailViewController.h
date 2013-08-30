//
//  ServiceDetailViewController.h
//  BlueCapUI
//
//  Created by Troy Stribling on 8/28/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceDetailViewController : UITableViewController <BlueCapServiceDelegate>

@property(nonatomic, retain) BlueCapService* service;

@end
