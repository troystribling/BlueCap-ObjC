//
//  BlueCapService+Private.h
//  BlueCap
//
//  Created by Troy Stribling on 8/26/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapService.h"

@interface BlueCapService (Private)

@property(nonatomic, retain) NSMutableDictionary* discoveredCharcteristics;
@property(nonatomic, retain) NSMutableDictionary* discoveredIncludedCharacteristics;

@end
