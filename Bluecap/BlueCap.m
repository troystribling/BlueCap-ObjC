//
//  BlueCap.m
//  BlueCap
//
//  Created by Troy Stribling on 8/18/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCap.h"

void DebugLog(NSString* format, ...) {
#ifdef DEBUG
    va_list args;
    va_start(args, format);
    NSLogv(format, args);
    va_end(args);
#endif
}
