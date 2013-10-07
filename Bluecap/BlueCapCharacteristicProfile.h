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

- (void)write:(NSString*)__methodName usingBlock:(BlueCapCharacteristicProfileWrite)__writeBlock;
- (void)read:(NSString*)__methodName usingBlock:(BlueCapCharacteristicProfileRead)__readBlock;

- (void)whenDiscovered:(BlueCapCharacteristicProfileWhenDiscovered)__whenDiscoveredCallback;
- (void)processData:(BlueCapCharacteristicProfileProcessData)__processDataCallback;

@end
