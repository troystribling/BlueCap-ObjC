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
    int16_t littleVals[length];
    for (int i = 0; i < length; i++) {
        littleVals[i] = CFSwapInt16HostToLittle(hostVals[i]);
    }
    return [NSData dataWithBytes:littleVals length:2*length];
}

NSData* blueCapBigFromUnsignedInt16Array(uint16_t* hostVals, int length) {
    int16_t bigVals[length];
    for (int i = 0; i < length; i++) {
        bigVals[i] = CFSwapInt16HostToBig(hostVals[i]);
    }
    return [NSData dataWithBytes:bigVals length:2*length];
}

NSData* blueCapLittleFromUnsignedInt16(uint16_t hostVal) {
    uint16_t littleVal = CFSwapInt16HostToLittle(hostVal);
    return [NSData dataWithBytes:&littleVal length:2];
}

NSData* blueCapBigFromUnsignedInt16(uint16_t hostVal) {
    uint16_t bigVal = CFSwapInt16HostToBig(hostVal);
    return [NSData dataWithBytes:&bigVal length:2];
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

NSData* blueCapLittleFromInt16Array(int16_t* hostVals, int length) {
    int16_t littleVals[length];
    for (int i = 0; i < length; i++) {
        littleVals[i] = CFSwapInt16HostToLittle(hostVals[i]);
    }
    return [NSData dataWithBytes:littleVals length:2*length];
}

NSData* blueCapBigFromInt16Array(int16_t* hostVals, int length) {
    int16_t bigVals[length];
    for (int i = 0; i < length; i++) {
        bigVals[i] = CFSwapInt16HostToBig(hostVals[i]);
    }
    return [NSData dataWithBytes:bigVals length:2*length];
}

NSData* blueCapLittleFromInt16(int16_t hostVal) {
    int16_t littleVal = CFSwapInt16HostToLittle(hostVal);
    return [NSData dataWithBytes:&littleVal length:2];
}

NSData* blueCapBigFromInt16(int16_t hostVal) {
    int16_t bigVal = CFSwapInt16HostToBig(hostVal);
    return [NSData dataWithBytes:&bigVal length:2];
}

#pragma mark - Char

NSNumber* blueCapCharFromData(NSData* data, NSRange range) {
    int8_t val;
    [data getBytes:&val range:range];
    return [NSNumber numberWithChar:val];
}

NSData* blueCapCharArrayToData(int8_t* data, int length) {
    return [NSData dataWithBytes:data length:length];
}

NSData* blueCapCharToData(int8_t data) {
    return [NSData dataWithBytes:&data length:1];
}

#pragma mark - Unsigned Char

NSNumber* blueCapUnsignedCharFromData(NSData* data, NSRange range) {
    int8_t val;
    [data getBytes:&val range:range];
    return [NSNumber numberWithUnsignedChar:val];
}

NSData* blueCapUnsignedCharToData(uint8_t data) {
    return [NSData dataWithBytes:&data length:1];
}

NSData* blueCapUnsignedCharArrayToData(uint8_t* data, int length) {
    return [NSData dataWithBytes:data length:length];
}

