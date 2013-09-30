//
//  BlueCapCentralManager+Friend.m
//  BlueCap
//
//  Created by Troy Stribling on 8/25/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCentralManager+Friend.h"
#import "BlueCapPeripheral+Friend.h"

@implementation BlueCapCentralManager (Friend)

@dynamic centralManager;
@dynamic configuredObjects;
@dynamic mainQueue;
@dynamic callbackQueue;

- (void)syncMain:(dispatch_block_t)__syncBlock {
    dispatch_sync([BlueCapCentralManager sharedInstance].mainQueue, __syncBlock);
}

- (void)asyncMain:(dispatch_block_t)__asyncBlock {
    dispatch_async([BlueCapCentralManager sharedInstance].mainQueue, __asyncBlock);
}

- (void)syncCallback:(dispatch_block_t)__syncBlock {
    dispatch_sync([BlueCapCentralManager sharedInstance].callbackQueue, __syncBlock);
}

- (void)asyncCallback:(dispatch_block_t)__asyncBlock {
    dispatch_async([BlueCapCentralManager sharedInstance].callbackQueue, __asyncBlock);
}

@end
