//
//  BlueCapPeripheralProfile+Friend.m
//  BlueCap
//
//  Created by Troy Stribling on 9/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheralProfile+Friend.h"

@implementation BlueCapPeripheralProfile (Friend)

@dynamic name;
@dynamic serviceProfiles;

+ (BlueCapPeripheralProfile*)createWithName:(NSString*)__name andProfile:(BlueCapPeripheralProfileBlock)__profileBlock {
    BlueCapPeripheralProfile* peripheralProfile = [[self alloc] initWithName:__name];
    if (__profileBlock) {
        __profileBlock(peripheralProfile);
    }
    return peripheralProfile;
}

-(id)initWithName:(NSString*)__name {
    self = [super init];
    if (self) {
        self.name = __name;
        self.serviceProfiles = [NSMutableDictionary dictionary];
    }
    return self;
}

@end
