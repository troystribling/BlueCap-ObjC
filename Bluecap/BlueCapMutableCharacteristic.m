//
//  BlueCapMutableCharacteristic.m
//  BlueCap
//
//  Created by Troy Stribling on 11/4/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapMutableCharacteristic.h"
#import "BlueCapCharacteristicProfile+Friend.h"

@interface BlueCapMutableCharacteristic ()

@property(nonatomic, retain) CBMutableCharacteristic*       cbCharacteristic;

- (id)initWithProfile:(BlueCapCharacteristicProfile*)__profile;

@end

@implementation BlueCapMutableCharacteristic

#pragma mark - BlueCapCharacteristic

+ (BlueCapMutableCharacteristic*)createWithPrifile:(BlueCapCharacteristicProfile*)__profile {
    return [[BlueCapMutableCharacteristic alloc] initWithProfile:__profile];
}

- (id)initWithProfile:(BlueCapCharacteristicProfile*)__profile {
    self = [super init];
    if (self) {
        _profile = __profile;
        self.cbCharacteristic = [[CBMutableCharacteristic alloc] initWithType:_profile.UUID
                                                                   properties:_profile.properties
                                                                        value:nil
                                                                  permissions:_profile.permissions];
    }
    return self;
}

- (NSArray*)descriptors {
    return [NSArray array];
}

- (NSArray*)subscribedCentrals {
    return self.cbCharacteristic.subscribedCentrals;
}

- (CBAttributePermissions)permissions {
    return self.cbCharacteristic.permissions;
}

- (CBCharacteristicProperties)properties {
    return self.cbCharacteristic.properties;
}

- (CBUUID*)UUID {
    return self.cbCharacteristic.UUID;
}

- (BOOL)propertyEnabled:(CBCharacteristicProperties)__property {
    return self.properties & __property;
}

- (BOOL)permissionEnabled:(CBAttributePermissions)__permission {
    return self.permissions & __permission;
}

@end
