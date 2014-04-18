//
//  NSManagedObjectImporter.m
//  CoreDataStack
//
//  Created by Menno Wildeboer on 17/04/14.
//  Copyright (c) 2014 Menno. All rights reserved.
//

#import "NSManagedObjectImporter.h"
#import "NSManagedObject+Resource.h"

@implementation NSManagedObjectImporter

- (BOOL)importWithFeed:(NSArray *)objects
{
    Class managedObjectClass = self.objectClass;
    if (!managedObjectClass || ![managedObjectClass conformsToProtocol:@protocol(NSImportable)]) {
        return NO;
    }
    
    NSString *identifier = [self.objectClass identifierKey];
    if (identifier.length == 0) {
        return NO;
    }
    
    NSMutableDictionary *values = [NSMutableDictionary dictionaryWithCapacity:objects.count];
    [objects enumerateObjectsUsingBlock:^(id data, NSUInteger idx, BOOL *stop)
    {
        id object = [self.objectClass identifierFromItem:data atIndex:idx];
        if (object)
        {
            [values setObject:object forKey:@(idx)];
        }
    }];
    
    if (!values) {
        return NO;
    }
    
    NSMutableDictionary *entities = nil;
    if ([self.objectClass allowsDeletion])
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (%K IN %@)", identifier, [values allValues]];
        [[managedObjectClass findWithPredicate:predicate] delete];
        entities = [[[managedObjectClass all] groupBy:identifier] mutableCopy];
    }
    else
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K IN %@)", identifier, [values allValues]];
        entities = [[[[managedObjectClass findWithPredicate:predicate] sortBy:@{ identifier : @YES  }] groupBy:identifier] mutableCopy];
    }

    [values enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id identifier, BOOL *stop)
    {
        id entity = [entities[identifier] firstObject];
        if (!entity)
        {
            entity = [managedObjectClass create];
            entities[identifier] = entity;
        }
        
        id feedItem = [objects objectAtIndex:[key intValue]];
        [self.objectClass updateEntity:entity withItem:feedItem];
    }];
    return YES;
}

@end
