//
//  BlueCapPeripheralManager.h
//  BlueCap
//
//  Created by Troy Stribling on 11/3/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@interface BlueCapPeripheralManager : NSObject <CBPeripheralManagerDelegate>

@property(nonatomic, readonly) BOOL                         isAdvertising;
@property(nonatomic, readonly) CBPeripheralManagerState     state;

+(BlueCapPeripheralManager*)sharedInstance;

@end
