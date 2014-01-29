//
//  NSManagedObject+Resource.m
//  CoreDataStack
//
//  Created by Menno Wildeboer on 02/01/14.
//  Copyright (c) 2014 Menno. All rights reserved.
//

#import "NSManagedObject+Resource.h"
#import "NSManagedObjectContext+Stack.h"
#import "NSManagedObject+NSFetchRequest.h"
#import "NSManagedObject+Stack.h"

@implementation NSManagedObject (Resource)

+ (NSArray *)all
{
    return [self allInContext:[self managedObjectContext]];
}

+ (NSArray *)allInContext:(NSManagedObjectContext *)context
{
    return [self executeFetchRequest:[self requestInContext:context] inContext:context];
}

+ (id)first
{
    return [self firstInContext:[self managedObjectContext]];
}

+ (id)firstInContext:(NSManagedObjectContext *)context
{
    return [self executeFetchRequestAndReturnFirstObject:[self requestInContext:context]];
}

+ (NSUInteger)count
{
    return [self countInContext:[self managedObjectContext]];
}

+ (NSUInteger)countInContext:(NSManagedObjectContext *)context
{
    return [self countFetchRequest:[self requestInContext:context] inContext:context];
}

+ (instancetype)create
{
    return [self createInContext:[self managedObjectContext]];
}

+ (instancetype)createInContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
}

+ (instancetype)create:(NSDictionary *)attributes
{
    return [self create:attributes inContext:[self managedObjectContext]];
}

+ (instancetype)create:(NSDictionary *)attributes inContext:(NSManagedObjectContext *)context
{
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    [object update:attributes];
    return object;
}

+ (void)deleteAll
{
    [self deleteAllInContext:[self managedObjectContext]];
}

+ (void)deleteAllInContext:(NSManagedObjectContext *)context
{
    [[self allInContext:context] makeObjectsPerformSelector:@selector(delete)];
}

- (void)update:(NSDictionary *)data
{
    if (data && ![data isEqual:[NSNull null]])
        return;
    
    NSDictionary *attributes = [[self entity] attributesByName];
    for (NSString *key in attributes)
    {
        id value = data[key];
        if (value == nil || [value isEqual:[NSNull null]]) {
            continue;
        }
        
        [self setSafeValue:value forKey:key];
    }
}

- (void)delete
{
    if (self.managedObjectContext == nil) {
        return;
    }
    
    [self.managedObjectContext deleteObject:self];
}

- (void)save
{
    [[[self class] managedObjectContext] save];
}

- (void)saveOnCompletion:(void(^)(BOOL success, NSError *error))completion
{
    [[[self class] managedObjectContext] saveOnCompletion:completion];
}

#pragma mark - Private

- (void)setSafeValue:(id)value forKey:(id)key
{
    if (value == nil || value == [NSNull null]) {
        return;
    }
    
    NSDictionary *attributes = [[self entity] attributesByName];
    NSAttributeType attributeType = [[attributes objectForKey:key] attributeType];
    
    if ((attributeType == NSStringAttributeType) && ([value isKindOfClass:[NSNumber class]]))
        value = [value stringValue];
    
    else if ([value isKindOfClass:[NSString class]])
    {
        if ([self isIntegerAttributeType:attributeType])
            value = [NSNumber numberWithInteger:[value integerValue]];
        else if (attributeType == NSFloatAttributeType)
            value = [NSNumber numberWithDouble:[value doubleValue]];
        else if (attributeType == NSDateAttributeType)
            value = [self.defaultFormatter dateFromString:value];
    }
    [self setValue:value forKey:key];
}

- (BOOL)isIntegerAttributeType:(NSAttributeType)attributeType
{
    return (attributeType == NSInteger16AttributeType) || (attributeType == NSInteger32AttributeType) || (attributeType == NSInteger64AttributeType) || (attributeType == NSBooleanAttributeType);
}

- (NSDateFormatter *)defaultFormatter
{
    static NSDateFormatter *sharedFormatter;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedFormatter = [[NSDateFormatter alloc] init];
        sharedFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss z";
    });
    return sharedFormatter;
}

@end
