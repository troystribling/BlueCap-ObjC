//
//  BlueCapMutableService.m
//  BlueCap
//
//  Created by Troy Stribling on 11/4/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapMutableService.h"
#import "BlueCapServiceProfile+Friend.h"

@interface BlueCapMutableService ()

@property(nonatomic, retain) CBMutableService*  cbService;

- (id)initWithProfile:(BlueCapServiceProfile*)__profile;

@end

@implementation BlueCapMutableService

+ (BlueCapMutableService*)createWithProfile:(BlueCapServiceProfile*)__profile {
    return [[BlueCapMutableService alloc] initWithProfile:__profile];
}

- (id)initWithProfile:(BlueCapServiceProfile*)__profile {
    self = [super init];
    if (self) {
        _profile = __profile;
        self.cbService = [[CBMutableService alloc] initWithType:_profile.UUID primary:YES];
    }
    return self;
}

- (CBUUID*)UUID {
    return self.cbService.UUID;
}

- (NSArray*)characteristics {
    return [NSArray array];
}

- (NSArray*)includedServices {
    return [NSArray array];
}

- (BOOL)isPrimary {
    return self.cbService.isPrimary;
}


@end
