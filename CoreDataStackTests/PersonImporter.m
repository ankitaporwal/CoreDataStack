//
//  PersonImporter.m
//  CoreDataStack
//
//  Created by Menno Wildeboer on 30/04/14.
//  Copyright (c) 2014 Menno. All rights reserved.
//

#import "PersonImporter.h"
#import "Person.h"

@implementation PersonImporter

- (BOOL)shouldDeleteObjects
{
    return self.allowsDeletion;
}

- (BOOL)shouldDeleteObject:(id)managedObject
{
    return self.allowsDeletion;
}

- (Class)managedObjectClass
{
    return [Person class];
}

- (id <NSCopying>)managedObjectIdentifier
{
    return @"personID";
}

- (id)identifierForData:(NSDictionary *)data atIndex:(NSUInteger)index
{
    return @"id";
}

- (void)updateObject:(Person *)person withData:(NSDictionary *)data
{
    person.personID = [data objectForKey:@"id"];
}

@end
