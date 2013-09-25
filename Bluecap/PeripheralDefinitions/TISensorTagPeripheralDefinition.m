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
    [[BlueCapCentralManager sharedInstance] createPeripheralDefinitionWithUUID:@"9C4EEB7D-BE3A-E942-1539-CB7AD105CE5D" andDefinition:^(BlueCapPeripheralDefinition* __peripeheralDefinition) {
    }];
}

@end
