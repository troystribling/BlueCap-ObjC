//
//  BlueCapCharacteristicProfile+Friend.m
//  BlueCap
//
//  Created by Troy Stribling on 9/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristicProfile+Friend.h"

@implementation BlueCapCharacteristicProfile (Friend)

@dynamic UUID;
@dynamic name;
@dynamic valueObjects;
@dynamic valueNames;
@dynamic serializeNamedObjectCallback;
@dynamic serializeObjectCallback;
@dynamic deserializeDataCallback;
@dynamic stringValueCallback;
@dynamic afterDiscoveredCallback;


+ (BlueCapCharacteristicProfile*)createWithUUID:(NSString*)__uuidString name:(NSString*)__name andProfile:(BlueCapCharacteristicProfileBlock)__profileBlock {
    BlueCapCharacteristicProfile* characteristicProfile = [[self alloc] initWithUUID:__uuidString andName:__name];
    if (__profileBlock) {
        __profileBlock(characteristicProfile);
    }
    return characteristicProfile;
}

-(id)initWithUUID:(NSString*)__uuidString andName:(NSString*)__name {
    self = [super init];
    if (self) {
        self.name = __name;
        self.UUID = [CBUUID UUIDWithString:__uuidString];
        self.valueObjects = [NSMutableDictionary dictionary];
        self.valueNames = [NSMutableDictionary dictionary];
    }
    return self;
}
@end
