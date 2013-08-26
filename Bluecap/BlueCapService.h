//
//  BlueCapService.h
//  BlueCap
//
//  Created by Troy Stribling on 8/24/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

@class BlueCapPeripheral;

@interface BlueCapService : NSObject

@property(nonatomic, readonly) CBUUID* UUID;
@property(nonatomic, readonly) NSArray* characteristics;
@property(nonatomic, readonly) NSArray* includedServices;
@property(nonatomic, readonly) BlueCapPeripheral* peripheral;
@property(nonatomic, readonly) BOOL isPrimary;

+ (BlueCapService*)withCBService:(CBService*)__cbservice andPeripheral:(BlueCapPeripheral*)__periphepral;

@end
