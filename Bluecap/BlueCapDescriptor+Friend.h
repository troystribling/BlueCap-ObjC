//
//  BlueCapDescriptor+Friend.h
//  BlueCap
//
//  Created by Troy Stribling on 8/31/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapDescriptor.h"

@interface BlueCapDescriptor (Friend)

@property(nonatomic, retain) CBDescriptor*                  cbDescriptor;
@property(nonatomic, retain) BlueCapCharacteristic*         characteristic;
@property(nonatomic, copy) BlueCapDescriptorDataCallback    afterReadCallback;
@property(nonatomic, copy) BlueCapDescriptorDataCallback    afterWriteCallback;

+ (BlueCapDescriptor*)withCBDiscriptor:(CBDescriptor*)__descriptor andChracteristic:(BlueCapCharacteristic*)__chracteristic;
- (id)initWithCBDiscriptor:(CBDescriptor*)__descriptor andChracteristic:(BlueCapCharacteristic*)__chracteristic;

- (void)didUpdateValue:(NSError*)error;
- (void)didWriteValue:(NSError*)error;

@end
