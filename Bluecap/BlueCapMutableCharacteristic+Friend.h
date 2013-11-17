//
//  BlueCapMutableCharacteristic+Friend.h
//  BlueCap
//
//  Created by Troy Stribling on 11/13/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapMutableCharacteristic.h"

@interface BlueCapMutableCharacteristic (Friend)

@property(nonatomic, retain) CBMutableCharacteristic*           cbCharacteristic;
@property(nonatomic, copy) BlueCapMutableCharacteristicCallback processWriteCallback;

@end
