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

#pragma mark - UnsignedInt16

NSNumber* blueCapUnsignedInt16LittleFromData(NSData* data, NSRange range) {
    uint16_t val;
    [data getBytes:&val range:range];
    return [NSNumber numberWithUnsignedShort:CFSwapInt16LittleToHost(val)];
}

NSNumber* blueCapUnsignedInt16BigFromData(NSData* data, NSRange range) {
    uint16_t val;
    [data getBytes:&val range:range];
    return [NSNumber numberWithUnsignedShort:CFSwapInt16BigToHost(val)];
}

NSData* blueCapLittleFromUnsignedInt16Array(uint16_t* hostVals, int length) {
    int16_t littleVals[2];
    for (int i = 0; i < length; i++) {
        littleVals[i] = CFSwapInt16LittleToHost(hostVals[i]);
    }
    return [NSData dataWithBytes:&littleVals length:2*length];
}

NSData* blueCapBigFromUnsignedInt16Array(uint16_t* hostVals, int length) {
    int16_t bigVals[2];
    for (int i = 0; i < length; i++) {
        bigVals[i] = CFSwapInt16BigToHost(hostVals[i]);
    }
    return [NSData dataWithBytes:&bigVals length:2*length];
}

#pragma mark - Int16

NSNumber* blueCapInt16LittleFromData(NSData* data, NSRange range) {
    int16_t val;
    [data getBytes:&val range:range];
    return [NSNumber numberWithShort:CFSwapInt16LittleToHost(val)];
}

NSNumber* blueCapInt16BigFromData(NSData* data, NSRange range) {
    int16_t val;
    [data getBytes:&val range:range];
    return [NSNumber numberWithShort:CFSwapInt16BigToHost(val)];
}

#pragma mark - Char

NSNumber* blueCapCharFromData(NSData* data, NSRange range) {
    int8_t val;
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
