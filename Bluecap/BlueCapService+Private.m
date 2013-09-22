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
@dynamic onChracteristicsDiscoveredCallback;

- (void)didDiscoverCharacterics:(NSArray*)__discoveredCharacteristics {
    if (self.onChracteristicsDiscoveredCallback) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.onChracteristicsDiscoveredCallback(__discoveredCharacteristics);
        }];
    }
}

@end
