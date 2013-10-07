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

-(NSData*)value {
    __block NSData* __value = [NSData data];
    [[BlueCapCentralManager sharedInstance] syncMain:^{
        __value = self.bcCharacteristic.cbCharacteristic.value;
    }];
    return __value;
}

- (NSString*)stringValue {
    return [[NSString alloc] initWithData:self.value encoding:NSUTF8StringEncoding];
}

- (NSDictionary*)processedValues {
    NSDictionary* values = [NSDictionary dictionary];
    BlueCapCharacteristicProfile* profile = self.characteristic.profile;
    if (profile) {
        if (profile.processReadCallback) {
            values = profile.processReadCallback(self.value);
        }
    }
    return values;
}

@end
