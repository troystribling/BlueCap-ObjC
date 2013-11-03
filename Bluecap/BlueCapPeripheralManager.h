//
//  BlueCapPeripheralManager.h
//  BlueCap
//
//  Created by Troy Stribling on 11/3/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlueCapPeripheralManager : NSObject <CBPeripheralManagerDelegate>

+(BlueCapPeripheralManager*)sharedInstance;

@end
