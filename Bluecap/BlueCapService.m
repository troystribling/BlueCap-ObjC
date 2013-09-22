//
//  BlueCapService.m
//  BlueCap
//
//  Created by Troy Stribling on 8/24/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//


#import "BlueCapPeripheral+Private.h"
#import "BlueCapService.h"

@interface BlueCapService ()

@property(nonatomic, retain) CBService*                                 cbService;
@property(nonatomic, retain) NSMutableArray*                            discoveredCharacteristics;
@property(nonatomic, retain) NSMutableArray*                            discoveredIncludedServices;
@property(nonatomic, copy) BlueCapCharacteristicsDiscoveredCallback     onChracteristicsDiscovered;

@end

@implementation BlueCapService

#pragma mark -
#pragma mark BlueCapService

+ (BlueCapService*)withCBService:(CBService*)__cbservice andPeripheral:(BlueCapPeripheral*)__peripheral {
    return [[BlueCapService alloc] initWithCBService:__cbservice andPeripheral:__peripheral];
}

- (id)initWithCBService:(CBService*)__cbService  andPeripheral:(BlueCapPeripheral*)__periphepral{
    self = [super init];
    if (self) {
        self.cbService = __cbService;
        _peripheral = __periphepral;
        self.discoveredCharacteristics = [NSMutableArray array];
        self.discoveredIncludedServices = [NSMutableArray array];
    }
    return self;
}

- (CBUUID*)UUID {
    return self.cbService.UUID;
}

- (NSArray*)characteristics {
    return [NSArray arrayWithArray:self.discoveredCharacteristics];
}

- (NSArray*)includedServices {
    return [NSArray arrayWithArray:self.discoveredIncludedServices];
}

- (BOOL)isPrimary {
    return self.cbService.isPrimary;
}

- (void)discoverAllCharacteritics:(BlueCapCharacteristicsDiscoveredCallback)__onChracteristicDiscovery {
    self.onChracteristicsDiscovered = __onChracteristicDiscovery;
    [_peripheral.cbPeripheral discoverCharacteristics:nil forService:self.cbService];
}

- (void)discoverCharacteristics:(NSArray*)__characteristics onDiscovery:(BlueCapCharacteristicsDiscoveredCallback)__onChracteristicDiscovery {
    self.onChracteristicsDiscovered = __onChracteristicDiscovery;
    [_peripheral.cbPeripheral discoverCharacteristics:__characteristics forService:self.cbService];
}

#pragma mark -
#pragma mark BlueCapService PrivateAPI

@end
