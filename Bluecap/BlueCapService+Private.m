//
//  BlueCapService+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapService+Private.h"
#import "BlueCapCharacteristic+Private.h"
#import "BlueCapCentralManager+Private.h"

@implementation BlueCapService (Private)

@dynamic cbService;
@dynamic discoveredCharacteristics;
@dynamic discoveredIncludedServices;
@dynamic peripheral;
@dynamic definition;

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
    if (self.onChracteristicsDiscoveredCallback) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.onChracteristicsDiscoveredCallback(__discoveredCharacteristics);
        }];
    }
}

@end
