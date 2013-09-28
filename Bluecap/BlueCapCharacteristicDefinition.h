//
//  BlueCapCharacteristicDefinition.h
//  BlueCap
//
//  Created by Troy Stribling on 9/23/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapBlocks.h"

@interface BlueCapCharacteristicDefinition : NSObject

@property(nonatomic, readonly) CBUUID*      UUID;
@property(nonatomic, retain) NSString*      name;

@end
