//
//  BlueCapCentralManager+Private.h
//  BlueCap
//
//  Created by Troy Stribling on 8/25/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCentralManager.h"

@interface BlueCapCentralManager (Private)

@property(nonatomic, retain) CBCentralManager*              centralManager;
@property(nonatomic, retain) dispatch_queue_t               centralManagerQueue;

- (void)sync:(dispatch_block_t)__syncBlock;
- (void)async:(dispatch_block_t)__asyncBlock;

@end
