//
//  TISensorTagPeripheralDefinition.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCap.h"
#import "TISensorTagPeripheralDefinition.h"

@implementation TISensorTagPeripheralDefinition

+ (void)define {
    [[BlueCapCentralManager sharedInstance] createPeripheralDefinitionWithUUID:@"" andDefinition:^(BlueCapPeripheralDefinition* __peripeheralDefinition) {
        
    }];
}

@end
