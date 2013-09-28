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

+ (void)create {
    [[BlueCapCentralManager sharedInstance] createPeripheralWithName:@"TI BLE Sensor Tag" andDefinition:^(BlueCapPeripheralDefinition* peripheralDefinition) {
        
        [peripheralDefinition createServiceWithUUID:@"F000AA00-0451-4000-B000-000000000000"
                                               name:@"IR Temperature Sensor"
                                      andDefinition:^(BlueCapServiceDefinition* serviceDefinition) {
        }];
        
    }];
}

@end
