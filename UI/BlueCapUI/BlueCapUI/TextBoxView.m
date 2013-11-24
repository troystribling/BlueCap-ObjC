//
//  TextBoxView.m
//  shade
//
//  Created by Troy Stribling on 4/6/13.
//  Copyright (c) 2013 Troy Stribling. All rights reserved.
//

#import "TextBoxView.h"
#import <QuartzCore/QuartzCore.h>

#define DISPLAY_MESSAGE_XOFFEST     15.0
#define DISPLAY_MESSAGE_YOFFEST     10.0
#define TEXTBOX_FONTSIZE            21.0f
#define TEXTBOX_ALPHA               0.5f
#define TEXTBOX_BORDER_WIDTH        1.0f

@interface TextBoxView ()

- (void)addViewsWithText:(NSString*)__text ofSize:(CGSize)__messageSize;
+ (CGSize)textViewSizeForMessage:(NSString*)__text constrainedToWidth:(float)__width;
+ (CGRect)textViewRectForSize:(CGSize)__messageSize;
+ (CGRect)displayViewRectForMessageSize:(CGSize)__messageSize;

@end

@implementation TextBoxView

+ (id)withText:(NSString*)__text andWidth:(float)__width {
    return [[self alloc] initWithText:__text constrainedToWidth:__width];
}

+ (id)withText:(NSString*)__text {
    return [[self alloc] initWithText:__text];
}

- (id)initWithText:(NSString*)__text constrainedToWidth:(float)__width {
    CGSize textSize = [self.class textViewSizeForMessage:__text constrainedToWidth:__width];
    self = [super initWithFrame:[self.class viewRectForMessageSize:textSize]];
    if (self) {
        [self addViewsWithText:__text ofSize:textSize];
    }
    return self;
}

- (id)initWithText:(NSString*)__text {
    CGSize textSize = [__text sizeWithFont:[UIFont systemFontOfSize:TEXTBOX_FONTSIZE]];
    self = [super initWithFrame:[self.class viewRectForMessageSize:textSize]];
    if (self) {
        [self addViewsWithText:__text ofSize:textSize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)__frame {
    self = [super initWithFrame:__frame];
    if (self) {
    }
    return self;
}

- (void)setBorderColor:(UIColor*)__color {
    self.layer.borderColor = __color.CGColor;
}

- (void)setBorderWidth:(float)__width {
    self.layer.borderWidth = __width;
}

- (void)setTextXOffset:(float)__xoffset andYOffset:(float)__yoffset {
    self.backgroundView.frame = CGRectMake(0.0f,
                                           0.0f,
                                           self.textLabel.frame.size.width + 2.0f * __xoffset,
                                           self.textLabel.frame.size.height + 2.0f * __yoffset);
    self.textLabel.frame = CGRectMake(__xoffset,
                                      __yoffset,
                                      self.textLabel.frame.size.width,
                                      self.textLabel.frame.size.height);
    self.frame = CGRectMake(0.0f,
                            0.0f,
                            self.textLabel.frame.size.width + 2.0f * __xoffset,
                            self.textLabel.frame.size.height + 2.0f * __yoffset);
}

+ (CGSize)textViewSizeForMessage:(NSString*)__text constrainedToWidth:(float)__width {
    return [__text sizeWithFont:[UIFont systemFontOfSize:21.0]
              constrainedToSize:CGSizeMake(__width, [[UIScreen mainScreen] bounds].size.height)
                  lineBreakMode:NSLineBreakByWordWrapping];
    
}

+ (CGRect)textViewRectForSize:(CGSize)__messageSize {
    return CGRectMake(DISPLAY_MESSAGE_XOFFEST,
                      DISPLAY_MESSAGE_YOFFEST,
                      __messageSize.width,
                      __messageSize.height);
}

+ (CGRect)displayViewRectForMessageSize:(CGSize)__messageSize {
    return CGRectMake(0.0f,
                      0.0f,
                      __messageSize.width +  2.0f * DISPLAY_MESSAGE_XOFFEST,
                      __messageSize.height + 2.0f * DISPLAY_MESSAGE_YOFFEST);
}

+ (CGRect)viewRectForMessageSize:(CGSize)__messageSize {
    return CGRectMake(0.0f,
                      0.0f,
                      __messageSize.width +  2.0f * DISPLAY_MESSAGE_XOFFEST,
                      __messageSize.height + 2.0f * DISPLAY_MESSAGE_YOFFEST);
}

- (void)addViewsWithText:(NSString*)__text ofSize:(CGSize)__textSize {
    
    CGRect textRect = [self.class textViewRectForSize:__textSize];
    self.textLabel = [[UILabel alloc] initWithFrame:textRect];
    self.textLabel.text = __text;
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.font = [UIFont systemFontOfSize:TEXTBOX_FONTSIZE];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.alpha = 1.0;
    self.textLabel.numberOfLines = 0;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.backgroundView.alpha = TEXTBOX_ALPHA;
    self.backgroundView.backgroundColor = [UIColor blackColor];
    self.backgroundView.layer.borderWidth = TEXTBOX_BORDER_WIDTH;
    self.backgroundView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self addSubview:self.backgroundView];
    [self addSubview:self.textLabel];
}

@end