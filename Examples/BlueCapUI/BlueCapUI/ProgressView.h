//
//  ProgressView.h
//  photio
//
//  Created by Troy Stribling on 5/14/12.
//  Copyright (c) 2012 imaginaryProducts. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TextBoxView;

@interface ProgressView : UIView {
}

@property(nonatomic, strong) TextBoxView    *textBoxView;
@property(nonatomic, strong) UIView         *backgroundView;

+ (id)progressView;
- (void)progressWithMessage:(NSString*)_message inView:(UIView*)_containerView;
- (void)remove;

@end