//
//  TextBoxView.h
//  shade
//
//  Created by Troy Stribling on 4/6/13.
//  Copyright (c) 2013 Troy Stribling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextBoxView : UIView

@property(nonatomic, strong) UIView     *backgroundView;
@property(nonatomic, strong) UILabel    *textLabel;

+ (id)withText:(NSString*)__text andWidth:(float)__width;
+ (id)withText:(NSString*)__text;
- (id)initWithText:(NSString*)__text constrainedToWidth:(float)__width;

- (void)setBorderColor:(UIColor*)__color;
- (void)setBorderWidth:(float)__width;
- (void)setTextXOffset:(float)__xoffset andYOffset:(float)__yoffset;

@end