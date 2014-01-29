//
//  NSManagedObject+NSFetchRequest.h
//  CoreDataStack
//
//  Created by Menno Wildeboer on 02/01/14.
//  Copyright (c) 2014 Menno. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (NSFetchRequest)

+ (NSFetchRequest *)request;
+ (NSFetchRequest *)requestInContext:(NSManagedObjectContext *)context;

+ (NSFetchRequest *)requestWhere:(NSDictionary *)keyValue;
+ (NSFetchRequest *)requestWhere:(NSDictionary *)keyValue inContext:(NSManagedObjectContext *)context;
+ (NSFetchRequest *)requestWhere:(NSDictionary *)keyValue sortedBy:(NSDictionary *)sort;
+ (NSFetchRequest *)requestWhere:(NSDictionary *)keyValue sortedBy:(NSDictionary *)sort inContext:(NSManagedObjectContext *)context;

+ (NSFetchRequest *)requestWithPredicate:(NSPredicate *)predicate;
+ (NSFetchRequest *)requestWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
+ (NSFetchRequest *)requestWithPredicate:(NSPredicate *)predicate sortedByDescriptors:(NSArray *)descriptors;
+ (NSFetchRequest *)requestWithPredicate:(NSPredicate *)predicate sortedByDescriptors:(NSArray *)descriptors inContext:(NSManagedObjectContext *)context;

+ (NSFetchRequest *)requestSortedBy:(NSDictionary *)sort;
+ (NSFetchRequest *)requestSortedBy:(NSDictionary *)sort inContext:(NSManagedObjectContext *)context;

@end
