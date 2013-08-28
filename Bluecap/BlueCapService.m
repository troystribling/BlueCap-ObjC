//
//  BlueCapService.m
//  BlueCap
//
//  Created by Troy Stribling on 8/24/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//


#import "BlueCapPeripheral.h"
#import "BlueCapPeripheral+Private.h"
#import "BlueCapService.h"

@interface BlueCapService () {
    CBService* cbService;
    BlueCapPeripheral* peripheral;
}

@property(nonatomic, retain) NSMutableDictionary* discoveredCharacteristics;
@property(nonatomic, retain) NSMutableDictionary* discoveredIncludedServices;

@end

@implementation BlueCapService

#pragma mark -
#pragma mark BlueCapService

+ (BlueCapService*)withCBService:(CBService*)__cbservice andPeripheral:(BlueCapPeripheral*)__peripheral {
    return [[BlueCapService alloc] initWithCBService:__cbservice andPeripheral:__peripheral];
}

- (id)initWithCBService:(CBService*)__cbservice  andPeripheral:(BlueCapPeripheral*)__periphepral{
    self = [super init];
    if (self) {
        cbService = __cbservice;
        peripheral = __periphepral;
    }
    return self;
}

- (CBUUID*)UUID {
    return cbService.UUID;
}

- (NSArray*)characteristics {
    return [self.discoveredCharacteristics allValues];
}

- (NSArray*)includedServices {
    return [self.discoveredIncludedServices allValues];
}

- (BlueCapPeripheral*)peripheral {
    return peripheral;
}

- (BOOL)isPrimary {
    return cbService.isPrimary;
}

- (void)discoverAllCharacteritics {
    [peripheral.cbPeripheral discoverCharacteristics:nil forService:cbService];
}

- (void)discoverCharacteristics:(NSArray*)__characteristics {
    [peripheral.cbPeripheral discoverCharacteristics:__characteristics forService:cbService];
}

#pragma mark -
#pragma mark BlueCapService PrivateAPI

@end
