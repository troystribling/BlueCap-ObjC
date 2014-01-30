//
//  UIAlertView+Extensions.m
//  BlueCapUI
//
//  Created by Troy Stribling on 11/25/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "UIAlertView+Extensions.h"

@implementation UIAlertView (Extensions)

+ (void)alertOnError:(NSError*)error {
    [[[UIAlertView alloc] initWithTitle:[error localizedDescription] message:[error localizedFailureReason] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK button title") otherButtonTitles:nil] show];
}

+ (void)showMessage:(NSString*)msg {
    [[[UIAlertView alloc] initWithTitle:msg
                                message:nil
                               delegate:nil
                      cancelButtonTitle:NSLocalizedString(@"OK", @"OK button title")
                      otherButtonTitles:nil] show];
}

@end
