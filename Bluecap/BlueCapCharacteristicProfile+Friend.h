//
//  BlueCapCharacteristicProfile+Friend.h
//  BlueCap
//
//  Created by Troy Stribling on 9/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristicProfile.h"

@interface BlueCapCharacteristicProfile (Friend)

@property(nonatomic, retain) CBUUID*                                                    UUID;
@property(nonatomic, retain) NSString*                                                  name;
@property(nonatomic, retain) NSDictionary*                                              valueObjects;
@property(nonatomic, retain) NSDictionary*                                              valueNames;
@property(nonatomic, copy) BlueCapCharacteristicProfileSerializeNamedObjectCallback     serializeNamedObjectCallback;
@property(nonatomic, copy) BlueCapCharacteristicProfileSerializeObjectCallback          serializeObjectCallback;
@property(nonatomic, copy) BlueCapCharacteristicProfileSerializeStringCallback          serializeStringValueCallback;
@property(nonatomic, copy) BlueCapCharacteristicProfileDeserializeDataCallback          deserializeDataCallback;
@property(nonatomic, copy) BlueCapCharacteristicProfileStringValueCallback              stringValueCallback;

@property(nonatomic, copy) BlueCapCharacteristicProfileAfterDiscoveredCallback      afterDiscoveredCallback;

+ (BlueCapCharacteristicProfile*)createWithUUID:(NSString*)__uuidString name:(NSString*)__name andProfile:(BlueCapCharacteristicProfileBlock)__profileBlock;

-(id)initWithUUID:(NSString*)__uuidString andName:(NSString*)__name;

- (NSDictionary*)deserializeValueObjects:(NSData*)__dataValue;

+ (NSData*)serializeObject:(id)__value usingProfile:(BlueCapCharacteristicProfile*)__profile;
+ (NSData*)serializeNamedObject:(NSString*)__name usingProfile:(BlueCapCharacteristicProfile*)__profile;
+ (NSData*)serializeString:(NSDictionary*)__value usingProfile:(BlueCapCharacteristicProfile*)__profile;

+ (NSDictionary*)deserializeData:(NSData *)__dataValue usingProfile:(BlueCapCharacteristicProfile*)__profile;
+ (NSDictionary*)stringValue:(NSDictionary*)__dataValue usingProfile:(BlueCapCharacteristicProfile*)__profile;

@end
