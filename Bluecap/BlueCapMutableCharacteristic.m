//
//  BlueCapMutableCharacteristic.m
//  BlueCap
//
//  Created by Troy Stribling on 11/4/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheralManager+Friend.h"
#import "BlueCapMutableCharacteristic.h"
#import "BlueCapCharacteristicProfile+Friend.h"

@interface BlueCapMutableCharacteristic ()

@property(nonatomic, retain) CBMutableCharacteristic*   cbCharacteristic;

- (id)initWithProfile:(BlueCapCharacteristicProfile*)__profile andData:(NSData*)__value;

@end

@implementation BlueCapMutableCharacteristic

#pragma mark - BlueCapCharacteristic

+ (BlueCapMutableCharacteristic*)withProfile:(BlueCapCharacteristicProfile*)__profile andObject:(id)__value {
    return [self withProfile:__profile andData:[BlueCapCharacteristicProfile serializeObject:__value usingProfile:__profile]];
}

+ (BlueCapMutableCharacteristic*)withProfile:(BlueCapCharacteristicProfile*)__profile andData:(NSData*)__value {
    return [[BlueCapMutableCharacteristic alloc] initWithProfile:__profile andData:__value];
}

+ (BlueCapMutableCharacteristic*)withProfile:(BlueCapCharacteristicProfile*)__profile andNamedValue:(NSString*)__name {
    return [self withProfile:__profile andData:[BlueCapCharacteristicProfile serializeNamedValue:__name usingProfile:__profile]];
}

+ (BlueCapMutableCharacteristic*)withProfile:(BlueCapCharacteristicProfile*)__profile {
    return [self withProfile:__profile andData:nil];
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

- (NSString*)name {
    return self.profile.name;
}

- (BOOL)propertyEnabled:(CBCharacteristicProperties)__property {
    return self.properties & __property;
}

- (BOOL)permissionEnabled:(CBAttributePermissions)__permission {
    return self.permissions & __permission;
}

- (BOOL)hasValues {
    return [self.profile hasValues];
}

- (NSData*)dataValue {
    __block NSData* __value = [NSData data];
    [[BlueCapPeripheralManager sharedInstance] syncMain:^{
        __value = self.cbCharacteristic.value;
    }];
    return __value;
}

- (NSDictionary*)value {
    NSDictionary* deserializedVals = [NSDictionary dictionary];
    if (self.profile.deserializeDataCallback) {
        deserializedVals = self.profile.deserializeDataCallback([self dataValue]);
    } else if ([self hasValues]) {
        deserializedVals = [self.profile deserializeDataValues:[self dataValue]];
    }
    return deserializedVals;
}

- (NSDictionary*)stringValue {
    NSDictionary* stringVals = [NSDictionary dictionary];
    if (self.profile.stringValueCallback) {
        stringVals = self.profile.stringValueCallback([self value]);
    } else if ([self hasValues]) {
        stringVals =[self value];
    }
    return stringVals;
}

- (NSArray*)allValues {
    NSArray* valueNames = [NSArray array];
    if ([self hasValues]) {
        valueNames = [self.profile allValues];
    }
    return valueNames;
}

#pragma mark - I/O

- (void)updateValueString:(NSString*)__value {
}

- (void)updateValueNamed:(NSString*)__name {
}

- (void)updateData:(NSData*)__value {
}

#pragma mark - Private

- (id)initWithProfile:(BlueCapCharacteristicProfile*)__profile andData:(NSData*)__value  {
    self = [super init];
    if (self) {
        _profile = __profile;
        self.cbCharacteristic = [[CBMutableCharacteristic alloc] initWithType:_profile.UUID
                                                                   properties:_profile.properties
                                                                        value:__value
                                                                  permissions:_profile.permissions];
    }
    return self;
}

@end
