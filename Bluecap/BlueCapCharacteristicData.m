//
//  BlueCapCharacteristicData.m
//  BlueCap
//
//  Created by Troy Stribling on 9/11/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCentralManager+Friend.h"
#import "BlueCapCharacteristic+Friend.h"
#import "BlueCapCharacteristicData+Friend.h"
#import "BlueCapCharacteristicProfile+Friend.h"

@interface BlueCapCharacteristicData ()

@property(nonatomic, retain) BlueCapCharacteristic* bcCharacteristic;

@end

@implementation BlueCapCharacteristicData

- (BlueCapCharacteristic*)characteristic {
    return self.bcCharacteristic;
}

- (NSData*)dataValue {
    __block NSData* __value = [NSData data];
    [[BlueCapCentralManager sharedInstance] syncMain:^{
        __value = self.bcCharacteristic.cbCharacteristic.value;
    }];
    return __value;
}

- (NSDictionary*)value {
    NSDictionary* deserializedVals = [NSDictionary dictionary];
    BlueCapCharacteristicProfile* profile = self.characteristic.profile;
    if (profile) {
        if (profile.deserializeDataCallback) {
            deserializedVals = profile.deserializeDataCallback([self dataValue]);
        }
    }
    return deserializedVals;
}

- (NSDictionary*)stringValue {
    NSDictionary* stringVals = [NSDictionary dictionary];
    BlueCapCharacteristicProfile* profile = self.characteristic.profile;
    if (profile) {
        if (profile.stringValueCallback) {
            stringVals = profile.stringValueCallback([self value]);
        }
    }
    return stringVals;
}

@end
