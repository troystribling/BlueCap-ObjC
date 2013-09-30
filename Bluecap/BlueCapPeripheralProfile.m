//
//  BlueCapPeripheralProfile.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheralProfile.h"
#import "BlueCapServiceProfile+Private.h"
#import "CBUUID+StringValue.h"

@interface BlueCapPeripheralProfile ()

@property(nonatomic, retain) NSString*              name;
@property(nonatomic, retain) NSMutableDictionary*   definedServices;

@end

@implementation BlueCapPeripheralProfile

#pragma mark -
#pragma mark Service Profile

-(NSString*)name {
    return _name;
}

- (BlueCapServiceProfile*)createServiceWithUUID:(NSString*)__uuidString andName:(NSString*)__name {
    return [self createServiceWithUUID:__uuidString name:__name andProfile:nil];
}

- (BlueCapServiceProfile*)createServiceWithUUID:(NSString*)__uuidString name:(NSString*)__name andProfile:(BlueCapServiceProfileBlock)__profileBlock {
    BlueCapServiceProfile* serviceProfile = [BlueCapServiceProfile createWithUUID:__uuidString name:__name andProfile:__profileBlock];
    [self.definedServices setObject:serviceProfile forKey:serviceProfile.UUID];
    DLog(@"Service Profile Defined: %@-%@", serviceProfile.name, [serviceProfile.UUID stringValue]);
    return serviceProfile;
}

@end
