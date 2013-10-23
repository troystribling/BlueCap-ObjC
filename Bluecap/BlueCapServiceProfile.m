//
//  BlueCapServiceProfile.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapServiceProfile+Friend.h"
#import "BlueCapCharacteristicProfile+Friend.h"
#import "CBUUID+StringValue.h"

@interface BlueCapServiceProfile ()

@property(nonatomic, retain) CBUUID*                UUID;
@property(nonatomic, retain) NSString*              name;
@property(nonatomic, retain) NSMutableDictionary*   characteristicProfiles;

@end

@implementation BlueCapServiceProfile

- (CBUUID*)UUID {
    return _UUID;
}

- (NSString*)name {
    return _name;
}

#pragma mark - Characteristic Profile

- (BlueCapCharacteristicProfile*)createCharacteristicWithUUID:(NSString*)__uuidString andName:(NSString*)__name {
    return [self createCharacteristicWithUUID:__uuidString name:__name andProfile:nil];
}

- (BlueCapCharacteristicProfile*)createCharacteristicWithUUID:(NSString*)__uuidString name:(NSString*)__name andProfile:(BlueCapCharacteristicProfileBlock)__profileBlock {
    BlueCapCharacteristicProfile* chracteristicProfile = [BlueCapCharacteristicProfile createWithUUID:__uuidString name:__name andProfile:__profileBlock];
    [self.characteristicProfiles setObject:chracteristicProfile forKey:chracteristicProfile.UUID];
    DLog(@"Characteristic Profile Defined: %@-%@", chracteristicProfile.name, [chracteristicProfile.UUID stringValue]);
    return chracteristicProfile;
}

@end
