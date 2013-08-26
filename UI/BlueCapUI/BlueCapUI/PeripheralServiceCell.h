//
//  PeripheralServiceCell.h
//  BlueCapUI
//
//  Created by Troy Stribling on 8/25/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeripheralServiceCell : UITableViewCell

@property(nonatomic, retain) IBOutlet UILabel*  uuidLabel;
@property(nonatomic, retain) IBOutlet UILabel*  serviceTypeLabel;

@end
