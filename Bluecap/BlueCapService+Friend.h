//
//  BlueCapService+Friend.h
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapService.h"

@class BlueCapCharacteristic;

@interface BlueCapService (Friend)

@property(nonatomic, retain) CBService*                                 cbService;
@property(nonatomic, retain) NSMutableDictionary*                       discoveredCharacteristics;
@property(nonatomic, retain) NSMutableArray*                            discoveredIncludedServices;
@property(nonatomic, retain) BlueCapPeripheral*                         peripheral;
@property(nonatomic, copy) BlueCapCharacteristicsDiscoveredCallback     afterChracteristicsDiscoveredCallback;
@property(nonatomic, retain) BlueCapServiceProfile*                     profile;

+ (BlueCapService*)withCBService:(CBService*)__cbservice andPeripheral:(BlueCapPeripheral*)__peripheral;
- (void)didDiscoverCharacterics:(NSArray*)__discoveredCharacteristics;

@end
