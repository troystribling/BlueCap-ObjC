//
//  BlueCapServiceProfile+Friend.m
//  BlueCap
//
//  Created by Troy Stribling on 9/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapServiceProfile+Friend.h"

@implementation BlueCapServiceProfile (Friend)

@dynamic UUID;
@dynamic name;
@dynamic characteristicProfilesDictionary;

+ (BlueCapServiceProfile*)createWithUUID:(NSString*)__uuidString name:(NSString*)__name andProfile:(BlueCapServiceProfileBlock)__profileBlock {
    BlueCapServiceProfile* serviceProfile = [[self alloc] initWithUUID:__uuidString andName:__name];
    if (__profileBlock) {
        __profileBlock(serviceProfile);
    }
    return serviceProfile;
}

-(id)initWithUUID:(NSString*)__uuidString andName:(NSString*)__name {
    self = [super init];
    if (self) {
        self.name = __name;
        self.UUID = [CBUUID UUIDWithString:__uuidString];
        self.characteristicProfilesDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

@end
