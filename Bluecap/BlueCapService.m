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

- (id)initWithCBService:(CBService*)__cbService  andPeripheral:(BlueCapPeripheral*)__periphepral{
    self = [super init];
    if (self) {
        cbService = __cbService;
        _peripheral = __periphepral;
        self.discoveredCharacteristics = [NSMutableDictionary dictionary];
        self.discoveredIncludedServices = [NSMutableDictionary dictionary];
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

- (BOOL)isPrimary {
    return cbService.isPrimary;
}

- (void)discoverAllCharacteritics {
    [_peripheral.cbPeripheral discoverCharacteristics:nil forService:cbService];
}

- (void)discoverCharacteristics:(NSArray*)__characteristics {
    [_peripheral.cbPeripheral discoverCharacteristics:__characteristics forService:cbService];
}

#pragma mark -
#pragma mark BlueCapService PrivateAPI

@end
