//
//  BlueCapCentralManager+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 8/25/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCentralManager+Private.h"

@implementation BlueCapCentralManager (Private)

@dynamic centralManager;
@dynamic centralManagerQueue;

- (void)sync:(dispatch_block_t)__syncBlock {
    dispatch_sync([BlueCapCentralManager sharedInstance].centralManagerQueue, __syncBlock);
}

- (void)async:(dispatch_block_t)__asyncBlock {
    dispatch_async([BlueCapCentralManager sharedInstance].centralManagerQueue, __asyncBlock);
}

@end
