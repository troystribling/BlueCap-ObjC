//
//  BlueCapPeripheralManager+Friend.m
//  BlueCap
//
//  Created by Troy Stribling on 11/10/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheralManager+Friend.h"

@implementation BlueCapPeripheralManager (Friend)

@dynamic cbPeripheralManager;
@dynamic mainQueue;
@dynamic callbackQueue;

- (void)syncMain:(dispatch_block_t)__syncBlock {
    dispatch_sync([BlueCapPeripheralManager sharedInstance].mainQueue, __syncBlock);
}

- (void)asyncMain:(dispatch_block_t)__asyncBlock {
    dispatch_async([BlueCapPeripheralManager sharedInstance].mainQueue, __asyncBlock);
}

- (void)syncCallback:(dispatch_block_t)__syncBlock {
    dispatch_sync([BlueCapPeripheralManager sharedInstance].callbackQueue, __syncBlock);
}

- (void)asyncCallback:(dispatch_block_t)__asyncBlock {
    dispatch_async([BlueCapPeripheralManager sharedInstance].callbackQueue, __asyncBlock);
}

@end
