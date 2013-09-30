//
//  BlueCapServiceProfile+Friend.h
//  BlueCap
//
//  Created by Troy Stribling on 9/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapServiceProfile.h"

@interface BlueCapServiceProfile (Friend)

@property(nonatomic, retain) CBUUID*                        UUID;
@property(nonatomic, retain) NSString*                      name;
@property(nonatomic, retain) NSMutableDictionary*           definedCharacteristics;


+ (BlueCapServiceProfile*)createWithUUID:(NSString*)__uuidString name:(NSString*)__name andProfile:(BlueCapServiceProfileBlock)__ProfileBlock;

- (id)initWithUUID:(NSString*)__uuidString andName:(NSString*)__name;

@end
