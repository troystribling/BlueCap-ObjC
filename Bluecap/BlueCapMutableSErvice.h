//
//  BlueCapMutableService.h
//  BlueCap
//
//  Created by Troy Stribling on 11/4/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlueCapMutableService : NSObject

@property(nonatomic, readonly) CBUUID*      UUID;
@property(nonatomic, readonly) NSArray*     characteristics;
@property(nonatomic, readonly) NSArray*     includedServices;
@property(nonatomic, readonly) BOOL         isPrimary;

@end
