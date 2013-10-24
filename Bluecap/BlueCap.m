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

NSNumber* blueCapCharFromData(NSData* data, NSRange range) {
    int8_t val;
    [data getBytes:&val range:range];
    return [NSNumber numberWithChar:val];
}

NSNumber* blueCapUnsignedInt16FromData(NSData* data, NSRange range) {
    uint16_t val;
    [data getBytes:&val range:range];
    return [NSNumber numberWithChar:val];
}

NSNumber* blueCapInt16FromData(NSData* data, NSRange range) {
    int16_t val;
    [data getBytes:&val range:range];
    return [NSNumber numberWithChar:val];
}

NSNumber* blueCapUnsignedCharFromData(NSData* data) {
    int8_t val;
    [data getBytes:&val length:1];
    return [NSNumber numberWithUnsignedChar:val];
}

NSData* blueCapUnsignedCharToData(uint8_t data) {
    return [NSData dataWithBytes:&data length:1];
}
