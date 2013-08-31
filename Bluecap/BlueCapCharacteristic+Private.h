//
//  BlueCapCharacteristic+Private.h
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristic.h"

@interface BlueCapCharacteristic (Private)

@property(nonatomic, retain) CBCharacteristic*   cbCharacteristic;
@property(nonatomic, retain) NSMutableDictionary* discoveredDiscriptors;

@end
