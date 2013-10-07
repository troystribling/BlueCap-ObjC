//
//  BlueCapCharacteristicProfile.m
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristicProfile.h"

@interface BlueCapCharacteristicProfile ()

@property(nonatomic, retain) CBUUID*                                        UUID;
@property(nonatomic, retain) NSString*                                      name;
@property(nonatomic, retain) NSMutableDictionary*                           writeMethods;
@property(nonatomic, retain) NSMutableDictionary*                           readMethods;
@property(nonatomic, copy) BlueCapCharacteristicProfileWhenDiscovered       whenDiscoveredCallback;
@property(nonatomic, copy) BlueCapCharacteristicProfileProcessData          processDataCallback;

@end

@implementation BlueCapCharacteristicProfile

- (CBUUID*)UUID {
    return _UUID;
}

- (NSString*)name {
    return _name;
}

- (void)write:(NSString*)__methodName usingBlock:(BlueCapCharacteristicProfileWrite)__writeBlock {
    [self.writeMethods setObject:__writeBlock forKey:__methodName];
}

- (void)read:(NSString*)__methodName usingBlock:(BlueCapCharacteristicProfileRead)__readBlock {
    [self.writeMethods setObject:__readBlock forKey:__methodName];
}

- (void)whenDiscovered:(BlueCapCharacteristicProfileWhenDiscovered)__whenDiscoveredCallback {
    self.whenDiscoveredCallback = __whenDiscoveredCallback;
}

- (void)processData:(BlueCapCharacteristicProfileProcessData)__processDataCallback {
    self.processDataCallback = __processDataCallback;
}

@end
