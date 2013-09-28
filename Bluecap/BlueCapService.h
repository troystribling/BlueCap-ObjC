//
//  BlueCapService.h
//  BlueCap
//
//  Created by Troy Stribling on 8/24/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@class BlueCapPeripheral;
@class BlueCapService;
@class BlueCapServiceDefinition;

@interface BlueCapService : NSObject

@property(nonatomic, readonly) CBUUID*      UUID;
@property(nonatomic, readonly) NSArray*     characteristics;
@property(nonatomic, readonly) NSArray*     includedServices;
@property(nonatomic, readonly) BOOL         isPrimary;

- (BlueCapPeripheral*)peripheral;
- (BlueCapServiceDefinition*)definition;
- (BOOL)hasDefinition;

- (void)discoverAllCharacteritics:(BlueCapCharacteristicsDiscoveredCallback)__onChracteristicsDiscoveredCallback;
- (void)discoverCharacteristics:(NSArray*)__characteristics onDiscovery:(BlueCapCharacteristicsDiscoveredCallback)__onChracteristicsDiscoveredCallback;

@end
