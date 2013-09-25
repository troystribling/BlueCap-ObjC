//
//  BlueCapCommon.h
//  BlueCap
//
//  Created by Troy Stribling on 9/1/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

@class BlueCapPeripheralDefinition;
@class BlueCapServiceDefinition;
@class BlueCapChracteristicDefinition;

typedef void(^BlueCapPeripheralDefinitionBlock)(BlueCapPeripheralDefinition* __peripheralDefinition);
typedef void(^BlueCapServiceDefinitionBlock)(BlueCapServiceDefinition* __serviceDefinition);
typedef void(^BlueCapCharacteristicDefinitionBlock)(BlueCapChracteristicDefinition* __characteristicDefinition);
