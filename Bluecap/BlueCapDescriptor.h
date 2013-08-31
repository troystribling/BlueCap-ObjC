//
//  BlueCapDescriptor.h
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BlueCapCharacteristic;

@interface BlueCapDescriptor : NSObject

@property(nonatomic, readonly) id                       value;
@property(nonatomic, readonly) CBUUID*                  UUID;
@property(nonatomic, readonly) BlueCapCharacteristic*   characteristic;

+ (BlueCapDescriptor*)withCBDiscriptor:(CBDescriptor*)__descriptor andChracteristic:(BlueCapCharacteristic*)__chracteristic;

@end
