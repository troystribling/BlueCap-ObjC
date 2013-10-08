//
//  BlueCapCharacteristicProfile.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristicProfile.h"

@interface BlueCapCharacteristicProfile ()

@property(nonatomic, retain) CBUUID*                                            UUID;
@property(nonatomic, retain) NSString*                                          name;
@property(nonatomic, retain) NSMutableDictionary*                               writeMethods;
@property(nonatomic, copy) BlueCapCharacteristicProfileProcessReadCallback      processReadCallback;
@property(nonatomic, copy) BlueCapCharacteristicProfileWhenDiscoveredCallback   whenDiscoveredCallback;

@end

@implementation BlueCapCharacteristicProfile

- (CBUUID*)UUID {
    return _UUID;
}

- (NSString*)name {
    return _name;
}

- (void)serializeValueNamed:(NSString*)__methodName usingBlock:(BlueCapCharacteristicProfileWrite)__writeBlock {
    [self.writeMethods setObject:[__writeBlock copy] forKey:__methodName];
}

- (void)deserialize:(BlueCapCharacteristicProfileProcessReadCallback)__processDataCallback {
    self.processReadCallback = __processDataCallback;
}

- (void)whenDiscovered:(BlueCapCharacteristicProfileWhenDiscoveredCallback)__whenDiscoveredCallback {
    self.whenDiscoveredCallback = __whenDiscoveredCallback;
}

@end
