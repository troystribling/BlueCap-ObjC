//
//  BlueCapService.m
//  BlueCap
//
//  Created by Troy Stribling on 8/24/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapService.h"

@interface BlueCapService () {
    CBService* cbService;
    BlueCapPeripheral* _peripheral;
}

@property(nonatomic, retain) NSMutableDictionary* discoveredCharcteristics;
@property(nonatomic, retain) NSMutableDictionary* discoveredIncludedServices;

@end

@implementation BlueCapService

#pragma mark -
#pragma mark BlueCapService

+ (BlueCapService*)withCBService:(CBService*)__cbservice andPeripheral:(BlueCapPeripheral*)__periphepral {
    return [[BlueCapService alloc] initWithCBService:__cbservice andPeripheral:__periphepral];
}

- (id)initWithCBService:(CBService*)__cbservice  andPeripheral:(BlueCapPeripheral*)__periphepral{
    self = [super init];
    if (self) {
        cbService = __cbservice;
        _peripheral = __periphepral;
    }
    return self;
}

- (CBUUID*)UUID {
    return cbService.UUID;
}

- (NSArray*)characteristics {
    return [self.discoveredCharcteristics allValues];
}

- (NSArray*)includedServices {
    return [self.discoveredIncludedServices allValues];
}

- (BlueCapPeripheral*)peripheral {
    return _peripheral;
}

- (BOOL)isPrimary {
    return cbService.isPrimary;
}

#pragma mark -
#pragma mark BlueCapService PrivateAPI

@end
