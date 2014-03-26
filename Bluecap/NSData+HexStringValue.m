//
//  NSData+StringValue.m
//  BlueCap
//
//  Created by Troy Stribling on 3/25/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

#import "NSData+HexStringValue.h"

@implementation NSData (StringValue)

- (NSString*)hexStringValue {
    const unsigned char *dataBuffer = (const unsigned char *)[self bytes];
    if (!dataBuffer) {
        return [NSString string];
    }
    NSUInteger  dataLength  = [self length];
    NSMutableString *hexString  = [NSMutableString stringWithCapacity:(dataLength*2)];
    for (int i = 0; i < dataLength; ++i) {
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    }
    return [NSString stringWithString:hexString];
}

@end
