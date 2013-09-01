//
//  BlueCapPeripheral+Private.h
//  BlueCap
//
//  Created by Troy Stribling on 8/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheral.h"

@interface BlueCapPeripheral (Private)

@property(nonatomic, retain) CBPeripheral*          cbPeripheral;
@property(nonatomic, retain) NSMutableDictionary*   discoveredServices;

+ (BlueCapPeripheral*)withCBPeripheral:(CBPeripheral*)__cbPeripheral;
- (id)initWithCBPeripheral:(CBPeripheral*)__cbPeripheral;

@end
