//
//  BlueCapPeripheralProfile+Private.h
//  BlueCap
//
//  Created by Troy Stribling on 9/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheralProfile.h"

@interface BlueCapPeripheralProfile (Private)

@property(nonatomic, retain) NSString*              name;
@property(nonatomic, retain) NSMutableDictionary*   definedServices;

+ (BlueCapPeripheralProfile*)createWithName:(NSString*)__name andProfile:(BlueCapPeripheralProfileBlock)__profileBlock;
-(id)initWithName:(NSString*)__name;

@end
