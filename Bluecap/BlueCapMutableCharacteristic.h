//
//  BlueCapMutableCharacteristic.h
//  BlueCap
//
//  Created by Troy Stribling on 11/4/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlueCapMutableCharacteristic : NSObject

@property(nonatomic, readonly) NSArray*                     descriptors;
@property(nonatomic, readonly) NSArray*                     subscribedCentrals;
@property(nonatomic, readonly) CBAttributePermissions       permissions;
@property(nonatomic, readonly) CBCharacteristicProperties   properties;
@property(nonatomic, readonly) CBUUID*                      UUID;

- (BOOL)propertyEnabled:(CBCharacteristicProperties)__property;
- (BOOL)permissionEnabled:(CBAttributePermissions)__permission;

@end
