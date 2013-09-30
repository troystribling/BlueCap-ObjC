//
//  BlueCapCharacteristicProfile.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristicProfile.h"

@interface BlueCapCharacteristicProfile ()

@property(nonatomic, retain) CBUUID*      UUID;
@property(nonatomic, retain) NSString*      name;

@end

@implementation BlueCapCharacteristicProfile

- (CBUUID*)UUID {
    return _UUID;
}

- (NSString*)name {
    return _name;
}

@end
