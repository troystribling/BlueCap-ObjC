//
//  ProgressView.m
//  BlueCapUI
//
//  Created by Troy Stribling on 8/13/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "ProgressView.h"
#import "TextBoxView.h"

#define DISPLAY_MESSAGE_WIDTH       200.0
#define DISPLAY_REMOVE_DURATION     0.5
#define TEXTBOX_YOFFSET             20.0f

@interface ProgressView ()

@end

@implementation ProgressView

+ (id)progressView {
    return [[ProgressView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

- (void)progressWithMessage:(NSString*)__progressMessage inView:(UIView*)_containerView {
    self.textBoxView = [TextBoxView withText:__progressMessage andWidth:DISPLAY_MESSAGE_WIDTH];
    self.textBoxView.center = CGPointMake(self.center.x, self.center.y - TEXTBOX_YOFFSET);
    [self addSubview:self.textBoxView];
    [_containerView addSubview:self];
}

- (void)remove {
    [UIView animateWithDuration:DISPLAY_REMOVE_DURATION
                     animations:^{
                         self.alpha = 0.0;
                     }
                     completion:^(BOOL _finished) {
                         [self removeFromSuperview];
                         self.alpha = 1.0;
                     }
     ];
}

- (id)initWithFrame:(CGRect)_frame {
    self = [super initWithFrame:_frame];
    if (self) {
        self.backgroundView = [[UIView alloc] initWithFrame:_frame];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        self.backgroundView.alpha = 0.6;
        [self addSubview:self.backgroundView];
    }
    return self;
}

@end