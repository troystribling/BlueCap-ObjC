//
//  BlueCapService.m
//  BlueCap
//
//  Created by Troy Stribling on 8/24/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//


#import "BlueCapPeripheral+Private.h"
#import "BlueCapService.h"
#import "BlueCapCharacteristicDefinition.h"

@interface BlueCapService ()

@property(nonatomic, retain) CBService*                                 cbService;
@property(nonatomic, retain) NSMutableArray*                            discoveredCharacteristics;
@property(nonatomic, retain) NSMutableDictionary*                       definedCharacteristics;
@property(nonatomic, retain) NSMutableArray*                            discoveredIncludedServices;
@property(nonatomic, retain) BlueCapPeripheral*                         peripheral;
@property(nonatomic, copy) BlueCapCharacteristicsDiscoveredCallback     onChracteristicsDiscoveredCallback;

@end

@implementation BlueCapService

#pragma mark -
#pragma mark BlueCapService

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

#pragma mark -
#pragma mark Discover Characteritics

- (void)discoverAllCharacteritics:(BlueCapCharacteristicsDiscoveredCallback)__onChracteristicsDiscoveredCallback {
    self.onChracteristicsDiscoveredCallback = __onChracteristicsDiscoveredCallback;
    [_peripheral.cbPeripheral discoverCharacteristics:nil forService:self.cbService];
}

- (void)discoverCharacteristics:(NSArray*)__characteristics onDiscovery:(BlueCapCharacteristicsDiscoveredCallback)__onChracteristicsDiscoveredCallback {
    self.onChracteristicsDiscoveredCallback = __onChracteristicsDiscoveredCallback;
    [_peripheral.cbPeripheral discoverCharacteristics:__characteristics forService:self.cbService];
}

#pragma mark -
#pragma mark BlueCapService PrivateAPI

#pragma mark -
#pragma mark Characteristic Definition

- (BlueCapCahracteristicDefinition*)createCharacteristicWithUUID:(NSString*)__uuidString andName:(NSString*)__name {
    return [self createCharacteristicWithUUID:__uuidString name:__name andDefinition:nil];
}

- (BlueCapCahracteristicDefinition*)createCharacteristicWithUUID:(NSString*)__uuidString name:(NSString*)__name andDefinition:(BlueCapCharacteristicDefinitionBlock)__definitionBlock {
    return nil;
}

@end
