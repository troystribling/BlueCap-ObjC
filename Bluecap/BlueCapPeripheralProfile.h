//
//  BlueCapPeripheralProfile.h
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@interface BlueCapPeripheralProfile : NSObject

- (NSString*)name;

- (BlueCapServiceProfile*)createServiceWithUUID:(NSString*)__uuidString andName:(NSString*)__name;
- (BlueCapServiceProfile*)createServiceWithUUID:(NSString*)__uuidString name:(NSString*)__name andProfile:(BlueCapServiceProfileBlock)__profileBlock;

@end
