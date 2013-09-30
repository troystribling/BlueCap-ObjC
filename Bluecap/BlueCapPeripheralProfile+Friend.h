//
//  BlueCapPeripheralProfile+Friend.h
//  BlueCap
//
//  Created by Troy Stribling on 9/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapPeripheralProfile.h"

@interface BlueCapPeripheralProfile (Friend)

@property(nonatomic, retain) NSString*              name;
@property(nonatomic, retain) NSMutableDictionary*   serviceProfiles;

+ (BlueCapPeripheralProfile*)createWithName:(NSString*)__name andProfile:(BlueCapPeripheralProfileBlock)__profileBlock;
-(id)initWithName:(NSString*)__name;

@end
