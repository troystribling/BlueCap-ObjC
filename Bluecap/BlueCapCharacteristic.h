//
//  BlueCapCharacteristic.h
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlueCapCharacteristic : NSObject

@property(nonatomic, readonly) NSArray*             descriptors;
@property(nonatomic, readonly) BOOL                 isBroadcasted;
@property(nonatomic, readonly) BOOL                 isNotifying;
@property(nonatomic, readonly) NSArray*             properties;
@property(nonatomic, readonly) NSData*              value;

- (void)discoverDescriptors;

@end
