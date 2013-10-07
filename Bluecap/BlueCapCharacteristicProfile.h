//
//  BlueCapCharacteristicProfile.h
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@interface BlueCapCharacteristicProfile : NSObject

- (CBUUID*)UUID;
- (NSString*)name;

- (void)writeValueNamed:(NSString*)__methodName usingBlock:(BlueCapCharacteristicProfileWrite)__writeBlock;
- (void)processRead:(BlueCapCharacteristicProfileProcessReadCallback)__processDataCallback;
- (void)whenDiscovered:(BlueCapCharacteristicProfileWhenDiscoveredCallback)__whenDiscoveredCallback;

@end
