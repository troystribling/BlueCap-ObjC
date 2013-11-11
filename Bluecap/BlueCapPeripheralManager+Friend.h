//
//  BlueCapPeripheralManager+Friend.h
//  BlueCap
//
//  Created by Troy Stribling on 11/10/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheralManager.h"

@interface BlueCapPeripheralManager (Friend)

@property(nonatomic, retain) CBPeripheralManager*           cbPeripheralManager;
@property(nonatomic, retain) dispatch_queue_t               mainQueue;
@property(nonatomic, retain) dispatch_queue_t               callbackQueue;

- (void)syncMain:(dispatch_block_t)__syncBlock;
- (void)asyncMain:(dispatch_block_t)__asyncBlock;

- (void)syncCallback:(dispatch_block_t)__syncBlock;
- (void)asyncCallback:(dispatch_block_t)__asyncBlock;

@end
