//
//  BlueCapCharacteristicProfile+Friend.m
//  BlueCap
//
//  Created by Troy Stribling on 9/27/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import "BlueCapCharacteristicProfile+Friend.h"

@implementation BlueCapCharacteristicProfile (Friend)

@dynamic UUID;
@dynamic name;
@dynamic valueObjects;
@dynamic valueNames;
@dynamic serializeNamedObjectCallback;
@dynamic serializeObjectCallback;
@dynamic serializeStringValueCallback;
@dynamic deserializeDataCallback;
@dynamic stringValueCallback;
@dynamic afterDiscoveredCallback;


+ (BlueCapCharacteristicProfile*)createWithUUID:(NSString*)__uuidString name:(NSString*)__name andProfile:(BlueCapCharacteristicProfileBlock)__profileBlock {
    BlueCapCharacteristicProfile* characteristicProfile = [[self alloc] initWithUUID:__uuidString andName:__name];
    if (__profileBlock) {
        __profileBlock(characteristicProfile);
    }
    return characteristicProfile;
}

-(id)initWithUUID:(NSString*)__uuidString andName:(NSString*)__name {
    self = [super init];
    if (self) {
        self.permissions = CBAttributePermissionsReadable | CBAttributePermissionsWriteable;
        self.properties = CBCharacteristicPropertyRead | CBCharacteristicPropertyWrite | CBCharacteristicPropertyNotify;
        self.name = __name;
        self.UUID = [CBUUID UUIDWithString:__uuidString];
        self.valueObjects = [NSMutableDictionary dictionary];
        self.valueNames = [NSMutableDictionary dictionary];
        self.initialValue = nil;
    }
    return self;
}

+ (NSData*)serializeObject:(id)__value usingProfile:(BlueCapCharacteristicProfile*)__profile {
    NSData* serializedValue = nil;
    if (__profile) {
        BlueCapCharacteristicProfileSerializeObjectCallback serializeBlock = __profile.serializeObjectCallback;
        if (serializeBlock) {
            serializedValue = serializeBlock(__value);
        } else {
            [NSException raise:@"Must provide serialization block" format:@"serialization block is nil"];
        }
    } else {
        [NSException raise:@"Must provide profile" format:@"profile is nil"];
    }
    DLog(@"Serialized Object of length: %d", [serializedValue length]);
    return serializedValue;
}

+ (NSData*)serializeNamedObject:(NSString*)__name usingProfile:(BlueCapCharacteristicProfile*)__profile {
    NSData* serializedValue = nil;
    if (__profile) {
        id objectValue = [__profile.valueObjects objectForKey:__name];
        BlueCapCharacteristicProfileSerializeNamedObjectCallback serializeBlock = __profile.serializeNamedObjectCallback;
        if (objectValue && serializeBlock) {
            serializedValue = serializeBlock(__name, objectValue);
        } else if (objectValue) {
            if ([objectValue isKindOfClass:[NSData class]]) {
                serializedValue = objectValue;
            }
        } else {
            [NSException raise:@"Must provide valid value name and serialization block" format:@"value name '%@' is invalid or seialization block is nil", __name];
        }
    } else {
        [NSException raise:@"Must provide profile" format:@"profile is nil"];
    }
    DLog(@"Serialized Named Object of length: %d", [serializedValue length]);
    return serializedValue;
}

+ (NSData*)serializeString:(NSDictionary*)__value usingProfile:(BlueCapCharacteristicProfile*)__profile {
    NSData* serializedValue = nil;
    if (__profile) {
        BlueCapCharacteristicProfileSerializeStringCallback serializeBlock = __profile.serializeStringValueCallback;
        if (serializeBlock) {
            serializedValue = serializeBlock(__value);
        } else {
            [NSException raise:@"Must provide serialization block" format:@"serialization block is nil"];
        }
    } else {
        [NSException raise:@"Must provide profile" format:@"profile is nil"];
    }
    DLog(@"Serialized String of length: %d", [serializedValue length]);
    return serializedValue;
}

+ (NSDictionary*)deserializeData:(NSData *)__dataValue usingProfile:(BlueCapCharacteristicProfile*)__profile {
    NSDictionary* deserializedVals = [NSDictionary dictionary];
    if (__profile.deserializeDataCallback) {
        deserializedVals = __profile.deserializeDataCallback(__dataValue);
    } else if ([__profile hasValues]) {
        deserializedVals = [__profile deserializeValueObjects:__dataValue];
    } else {
        [NSException raise:@"Must provide deserialization block" format:@"deserialization block is nil"];
    }
    return deserializedVals;
}

+ (NSDictionary*)stringValue:(NSDictionary*)__dataValue usingProfile:(BlueCapCharacteristicProfile*)__profile {
    NSDictionary* stringVals = [NSDictionary dictionary];
    if (__profile.stringValueCallback) {
        stringVals = __profile.stringValueCallback(__dataValue);
    } else if ([__profile hasValues]) {
        stringVals = __dataValue;
    } else {
        [NSException raise:@"Must provide deserialization block" format:@"deserialization block is nil"];
    }
    return stringVals;
}

- (NSDictionary*)deserializeValueObjects:(NSData*)__dataValue {
    NSDictionary* deserializedVals = [NSDictionary dictionary];
    for(id objectValue in [self.valueObjects allValues]) {
        if ([objectValue isKindOfClass:[NSData class]]) {
            if ([objectValue isEqualToData:__dataValue]) {
                deserializedVals = [NSDictionary dictionaryWithObject:[self.valueNames objectForKey:objectValue] forKey:self.name];
                break;
            }
        }
    }
    return deserializedVals;
}

@end
