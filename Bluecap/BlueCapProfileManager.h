//
//  BlueCapProfileManager.h
//  BlueCap
//
//  Created by Troy Stribling on 11/9/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@interface BlueCapProfileManager : NSObject

@property(nonatomic, readonly) NSArray* services;

+ (BlueCapProfileManager*)sharedInstance;

- (BlueCapServiceProfile*)createServiceWithUUID:(NSString*)__uuidString andName:(NSString*)__name;
- (BlueCapServiceProfile*)createServiceWithUUID:(NSString*)__uuidString name:(NSString*)__name andProfile:(BlueCapServiceProfileBlock)__profileBlock;

@end
