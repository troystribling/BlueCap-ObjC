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
@dynamic serviceProfiles;
@dynamic mainQueue;
@dynamic callbackQueue;

- (void)syncMain:(dispatch_block_t)__syncBlock {
    dispatch_sync([BlueCapCentralManager sharedInstance].mainQueue, __syncBlock);
}

- (void)asyncMain:(dispatch_block_t)__asyncBlock {
    dispatch_async([BlueCapCentralManager sharedInstance].mainQueue, __asyncBlock);
}

- (void)delayMain:(float)__delay withBlock:(dispatch_block_t)__delayBlock {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(__delay * NSEC_PER_SEC));
    dispatch_after(popTime, [BlueCapCentralManager sharedInstance].mainQueue, __delayBlock);
}

- (void)syncCallback:(dispatch_block_t)__syncBlock {
    dispatch_sync([BlueCapCentralManager sharedInstance].callbackQueue, __syncBlock);
}

- (void)asyncCallback:(dispatch_block_t)__asyncBlock {
    dispatch_async([BlueCapCentralManager sharedInstance].callbackQueue, __asyncBlock);
}

- (void)delayCallback:(float)__delay withBlock:(dispatch_block_t)__delayBlock {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(__delay * NSEC_PER_SEC));
    dispatch_after(popTime, [BlueCapCentralManager sharedInstance].callbackQueue, __delayBlock);
}

@end
