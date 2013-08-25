//
//  BlueCapService.m
//  BlueCap
//
//  Created by Troy Stribling on 8/24/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapService.h"

@interface BlueCapService () {
    CBService* cbservice;
}

@end

@implementation BlueCapService

#pragma mark -
#pragma mark BlueCapService

- (id)initWithCBService:(CBService*)__cbservice {
    self = [super init];
    if (self) {
        cbservice = __cbservice;
    }
    return self;
}

#pragma mark -
#pragma mark BlueCapService PrivateAPI

@end
