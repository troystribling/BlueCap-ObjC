//
//  BlueCapCentralManager+Friend.h
//  BlueCap
//
//  Created by Troy Stribling on 8/25/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCentralManager.h"

#define ASYNC_CALLBACK(X, Y) if (X != nil) {                                                 \
                                 [[BlueCapCentralManager sharedInstance] asyncCallback:^{    \
                                     Y;                                                      \
                                 }];                                                         \
                             }


@interface BlueCapCentralManager (Friend)

@property(nonatomic, retain) CBCentralManager*              centralManager;
@property(nonatomic, retain) NSMutableDictionary*           serviceProfiles;
@property(nonatomic, retain) dispatch_queue_t               mainQueue;
@property(nonatomic, retain) dispatch_queue_t               callbackQueue;

- (void)syncMain:(dispatch_block_t)__syncBlock;
- (void)asyncMain:(dispatch_block_t)__asyncBlock;
- (void)delayMain:(float)__delay withBlock:(dispatch_block_t)__delayBlock;

- (void)syncCallback:(dispatch_block_t)__syncBlock;
- (void)asyncCallback:(dispatch_block_t)__asyncBlock;
- (void)delayCallback:(float)__delay withBlock:(dispatch_block_t)__delayBlock;

@end
