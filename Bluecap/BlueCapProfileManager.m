//
//  BlueCapProfileManager.m
//  BlueCap
//
//  Created by Troy Stribling on 11/9/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapProfileManager.h"
#import "BlueCapServiceProfile+Friend.h"
#import "CBUUID+StringValue.h"

@interface BlueCapProfileManager ()

@property(nonatomic, retain) NSMutableDictionary*   configuredServiceProfiles;

@end

static BlueCapProfileManager* thisBlueCapProfileManager = nil;

@implementation BlueCapProfileManager

+ (BlueCapProfileManager*)sharedInstance {
    @synchronized(self) {
        if (thisBlueCapProfileManager == nil) {
            thisBlueCapProfileManager = [[self alloc] init];
        }
    }
    return thisBlueCapProfileManager;
}

- (id)init {
    self = [super init];
    if (self) {
        self.configuredServiceProfiles = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSArray*)services {
    return [self.configuredServiceProfiles allValues];
}

- (BlueCapServiceProfile*)createServiceWithUUID:(NSString*)__uuidString andName:(NSString*)__name {
    return [self createServiceWithUUID:__uuidString name:__name andProfile:nil];
}

- (BlueCapServiceProfile*)createServiceWithUUID:(NSString*)__uuidString name:(NSString*)__name andProfile:(BlueCapServiceProfileBlock)__profileBlock {
    BlueCapServiceProfile* serviceProfile = [BlueCapServiceProfile createWithUUID:__uuidString name:__name andProfile:__profileBlock];
    [self.configuredServiceProfiles setObject:serviceProfile forKey:serviceProfile.UUID];
    DLog(@"Service Profile Defined: %@-%@", serviceProfile.name, [serviceProfile.UUID stringValue]);
    return serviceProfile;
}

@end
