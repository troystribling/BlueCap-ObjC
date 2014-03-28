//
//  NSString+DataFromHexString.m
//  BlueCap
//
//  Created by Troy Stribling on 3/27/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

#import "NSString+DataFromHexString.h"

@implementation NSString (DataFromHexString)

- (NSData*)dataFromHexString {
    [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableData* dataValue = [[NSMutableData alloc] init];
    unsigned char byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [self length]/2; i++) {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        byte = strtol(byte_chars, NULL, 16);
        [dataValue appendBytes:&byte length:1];
    }
    return dataValue;
}

@end
