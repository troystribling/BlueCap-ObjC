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
@class BlueCapServiceProfile;

@interface BlueCapService : NSObject

@property(nonatomic, readonly) CBUUID*      UUID;
@property(nonatomic, readonly) NSArray*     characteristics;
@property(nonatomic, readonly) NSArray*     includedServices;
@property(nonatomic, readonly) BOOL         isPrimary;
@property(nonatomic, readonly) NSString*    name;

- (BlueCapPeripheral*)peripheral;
- (BlueCapServiceProfile*)profile;
- (BOOL)hasProfile;

- (void)discoverAllCharacteritics:(BlueCapCharacteristicsDiscoveredCallback)_afterChracteristicsDiscoveredCallback;
- (void)discoverCharacteristics:(NSArray*)__characteristics afterDiscovery:(BlueCapCharacteristicsDiscoveredCallback)__afterChracteristicsDiscoveredCallback;

@end
