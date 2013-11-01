//
//  BlueCapServiceProfile.h
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@class BlueCapCharacteristicProfile;

@interface BlueCapServiceProfile : NSObject

@property(nonatomic, retain) NSArray*   characteristicProfiles;

- (CBUUID*)UUID;
- (NSString*)name;

- (BlueCapCharacteristicProfile*)createCharacteristicWithUUID:(NSString*)__uuidString andName:(NSString*)__name;
- (BlueCapCharacteristicProfile*)createCharacteristicWithUUID:(NSString*)__uuidString name:(NSString*)__name andProfile:(BlueCapCharacteristicProfileBlock)__profileBlock;

@end
