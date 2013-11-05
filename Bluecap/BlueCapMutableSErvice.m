//
//  BlueCapMutableService.m
//  BlueCap
//
//  Created by Troy Stribling on 11/4/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapMutableService.h"

@interface BlueCapMutableService ()

@property(nonatomic, retain) CBMutableService*  cbService;

@end

@implementation BlueCapMutableService

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
