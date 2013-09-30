//
//  BlueCapServiceProfile+Private.m
//  BlueCap
//
//  Created by Troy Stribling on 9/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapServiceProfile+Private.h"

@implementation BlueCapServiceProfile (Private)

@dynamic UUID;
@dynamic name;
@dynamic definedCharacteristics;

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
        self.definedCharacteristics = [NSMutableDictionary dictionary];
    }
    return self;
}

@end
