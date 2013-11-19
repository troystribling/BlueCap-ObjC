//
//  BlueCapMutableCharacteristic.m
//  BlueCap
//
//  Created by Troy Stribling on 11/4/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCap.h"
#import "BlueCapPeripheralManager+Friend.h"
#import "BlueCapMutableCharacteristic.h"
#import "BlueCapCharacteristicProfile+Friend.h"

@interface BlueCapMutableCharacteristic ()

@property(nonatomic, retain) CBMutableCharacteristic*           cbCharacteristic;
@property(nonatomic, copy) BlueCapMutableCharacteristicCallback processWriteCallback;

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

+ (BlueCapMutableCharacteristic*)withProfile:(BlueCapCharacteristicProfile*)__profile andString:(NSDictionary*)__value {
    return [self withProfile:__profile andData:[BlueCapCharacteristicProfile serializeString:__value usingProfile:__profile]];
}

+ (BlueCapMutableCharacteristic*)withProfile:(BlueCapCharacteristicProfile*)__profile andNamedValue:(NSString*)__name {
    return [self withProfile:__profile andData:[BlueCapCharacteristicProfile serializeNamedObject:__name usingProfile:__profile]];
}

+ (BlueCapMutableCharacteristic*)withProfile:(BlueCapCharacteristicProfile*)__profile {
    return [self withProfile:__profile andData:__profile.initialValue];
}

+ (NSArray*)withProfiles:(NSArray*)__profiles {
    NSMutableArray* characteristics = [NSMutableArray array];
    for (BlueCapCharacteristicProfile* profile in __profiles) {
        [characteristics addObject:[self withProfile:profile]];
    }
    return characteristics;
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

- (void)processWriteRequest:(BlueCapMutableCharacteristicCallback)__processWriteCallback {
    self.processWriteCallback = __processWriteCallback;
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

- (void)updateValueObject:(id)__value {
    [[BlueCapPeripheralManager sharedInstance].cbPeripheralManager updateValue:[BlueCapCharacteristicProfile serializeObject:__value usingProfile:self.profile]
                                                             forCharacteristic:self.cbCharacteristic
                                                          onSubscribedCentrals:nil];
}

- (void)updateValueString:(NSDictionary*)__value {
    [[BlueCapPeripheralManager sharedInstance].cbPeripheralManager updateValue:[BlueCapCharacteristicProfile serializeString:__value usingProfile:self.profile]
                                                             forCharacteristic:self.cbCharacteristic
                                                          onSubscribedCentrals:nil];
}

- (void)updateValueData:(NSData*)__value {
    [[BlueCapPeripheralManager sharedInstance].cbPeripheralManager updateValue:__value
                                                             forCharacteristic:self.cbCharacteristic
                                                          onSubscribedCentrals:nil];
    
}

- (void)updateValueNamed:(NSString*)__name {
    [[BlueCapPeripheralManager sharedInstance].cbPeripheralManager updateValue:[BlueCapCharacteristicProfile serializeNamedObject:__name usingProfile:self.profile]
                                                             forCharacteristic:self.cbCharacteristic
                                                          onSubscribedCentrals:nil];
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
