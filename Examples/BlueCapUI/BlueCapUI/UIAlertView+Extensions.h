//
//  UIAlertView+Extensions.h
//  BlueCapUI
//
//  Created by Troy Stribling on 11/25/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Extensions)

+ (void)alertOnError:(NSError*)error;
+ (void)alertOnError:(NSError*)error withDelegate:(id)delegate;
+ (void)showMessage:(NSString*)msg;


@end
