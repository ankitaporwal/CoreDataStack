//
//  NSManagedObject+NSFetchRequest.m
//  CoreDataStack
//
//  Created by Menno Wildeboer on 02/01/14.
//  Copyright (c) 2014 Menno. All rights reserved.
//

#import "NSManagedObject+NSFetchRequest.h"
#import "NSManagedObject+Stack.h"
#import "NSPredicate+Helpers.h"
#import "NSSortDescriptor+Helpers.h"

@implementation NSManagedObject (NSFetchRequest)

+ (NSFetchRequest *)request
{
    return [self requestInContext:[self managedObjectContext]];
}

+ (NSFetchRequest *)requestInContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    return request;
}

+ (NSFetchRequest *)requestWhere:(NSDictionary *)keyValue
{
    return [self requestWhere:keyValue inContext:[self managedObjectContext]];
}

+ (NSFetchRequest *)requestWhere:(NSDictionary *)keyValue inContext:(NSManagedObjectContext *)context
{
    NSPredicate *predicate = [NSPredicate predicateFromDictionary:keyValue];
    return [self requestWithPredicate:predicate sortedByDescriptors:nil inContext:[self managedObjectContext]];
}

+ (NSFetchRequest *)requestWhere:(NSDictionary *)keyValue sortedBy:(NSDictionary *)sort
{
    return [self requestWhere:keyValue sortedBy:sort inContext:[self managedObjectContext]];
}

+ (NSFetchRequest *)requestWhere:(NSDictionary *)keyValue sortedBy:(NSDictionary *)sort inContext:(NSManagedObjectContext *)context
{
    NSPredicate *predicate = [NSPredicate predicateFromDictionary:keyValue];
    NSArray *sortDescriptors = [NSSortDescriptor sortDescriptorsFromDictionary:sort];
    return [self requestWithPredicate:predicate sortedByDescriptors:sortDescriptors inContext:[self managedObjectContext]];
}

+ (NSFetchRequest *)requestWithPredicate:(NSPredicate *)predicate
{
    return [self requestWithPredicate:predicate sortedByDescriptors:nil inContext:[self managedObjectContext]];
}

+ (NSFetchRequest *)requestWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context
{
    return [self requestWithPredicate:predicate sortedByDescriptors:nil inContext:context];
}

+ (NSFetchRequest *)requestWithPredicate:(NSPredicate *)predicate sortedByDescriptors:(NSArray *)descriptors
{
    return [self requestWithPredicate:predicate sortedByDescriptors:descriptors inContext:[self managedObjectContext]];
}

+ (NSFetchRequest *)requestWithPredicate:(NSPredicate *)predicate sortedByDescriptors:(NSArray *)descriptors inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [self requestInContext:context];
    request.predicate = predicate;
    request.sortDescriptors = descriptors;
    return request;
}

+ (NSFetchRequest *)requestSortedBy:(NSDictionary *)sort
{
    return [self requestSortedBy:sort inContext:[self managedObjectContext]];
}

+ (NSFetchRequest *)requestSortedBy:(NSDictionary *)sort inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [self requestInContext:context];
    request.sortDescriptors = [NSSortDescriptor sortDescriptorsFromDictionary:sort];
    return request;
}

@end
