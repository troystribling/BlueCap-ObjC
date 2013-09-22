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
@dynamic onChracteristicsDiscovered;

- (void)didDiscoverCharacterics:(NSArray*)__discoveredCharacteristics {
    if (self.onChracteristicsDiscovered) {
        [[BlueCapCentralManager sharedInstance] asyncCallback:^{
            self.onChracteristicsDiscovered(__discoveredCharacteristics);
            self.onChracteristicsDiscovered = nil;
        }];
    }
}

@end
