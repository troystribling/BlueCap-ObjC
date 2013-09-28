//
//  BlueCapCharacteristicDefinition.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristicDefinition.h"

@interface BlueCapCharacteristicDefinition ()

@property(nonatomic, retain) CBUUID*      UUID;
@property(nonatomic, retain) NSString*      name;

@end

@implementation BlueCapCharacteristicDefinition

- (CBUUID*)UUID {
    return _UUID;
}

- (NSString*)name {
    return _name;
}

@end
