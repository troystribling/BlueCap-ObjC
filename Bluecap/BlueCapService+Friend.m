//
//  BlueCapService+Friend.m
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapService+Friend.h"
#import "BlueCapCharacteristic+Friend.h"
#import "BlueCapCentralManager+Friend.h"
#import "BlueCapCharacteristicProfile+Friend.h"

@implementation BlueCapService (Friend)

@dynamic cbService;
@dynamic discoveredCharacteristics;
@dynamic discoveredIncludedServices;
@dynamic peripheral;
@dynamic profile;

@dynamic onChracteristicsDiscoveredCallback;

+ (BlueCapService*)withCBService:(CBService*)__cbservice andPeripheral:(BlueCapPeripheral*)__peripheral {
    return [[BlueCapService alloc] initWithCBService:__cbservice andPeripheral:__peripheral];
}

- (id)initWithCBService:(CBService*)__cbService  andPeripheral:(BlueCapPeripheral*)__periphepral{
    self = [super init];
    if (self) {
        self.cbService = __cbService;
        self.peripheral = __periphepral;
        self.discoveredCharacteristics = [NSMutableArray array];
        self.discoveredIncludedServices = [NSMutableArray array];
    }
    return self;
}

- (void)didDiscoverCharacterics:(NSArray*)__discoveredCharacteristics {
    [self callCharacteristicWriteWhenDiscovered:__discoveredCharacteristics];
    if (self.onChracteristicsDiscoveredCallback) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.onChracteristicsDiscoveredCallback(__discoveredCharacteristics);
        }];
    }
}

- (void)callCharacteristicWriteWhenDiscovered:(NSArray*)__discoveredCharacteristics {
    for(BlueCapCharacteristic* charcteristic in __discoveredCharacteristics) {
        if (charcteristic.profile) {
            if (charcteristic.profile.writeWhenDiscoveredCallback) {
                [charcteristic write:charcteristic.profile.writeWhenDiscoveredCallback() onWrite:nil];
            }
        }
    }
}

@end
