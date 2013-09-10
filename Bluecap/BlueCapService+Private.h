//
//  BlueCapService+Private.h
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapService.h"

@class BlueCapCharacteristic;

@interface BlueCapService (Private)

@property(nonatomic, retain) CBService* cbService;
@property(nonatomic, retain) NSMutableArray* discoveredCharacteristics;
@property(nonatomic, retain) NSMutableArray* discoveredIncludedServices;

- (BlueCapCharacteristic*)chracteristicFor:(CBCharacteristic*)__cbCharacteristic;

@end
