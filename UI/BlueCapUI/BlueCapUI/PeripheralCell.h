//
//  PeripheralCell.h
//  BlueCapUI
//
//  Created by Troy Stribling on 8/21/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeripheralCell : UITableViewCell

@property(nonatomic, retain) IBOutlet UILabel*                  rssiLabel;
@property(nonatomic, retain) IBOutlet UILabel*                  nameLabel;
@property(nonatomic, retain) IBOutlet UIActivityIndicatorView*  connectingActivityIndicator;

@end
