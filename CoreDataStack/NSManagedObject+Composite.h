//
//  NSManagedObject+Composite.h
//  CoreDataStack
//
//  Created by Menno Wildeboer on 02/01/14.
//  Copyright (c) 2014 Menno. All rights reserved.
//

#import <CoreData/CoreData.h>

@protocol NSManagedObjectComposite <NSObject>

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readonly) NSFetchRequest         *fetchRequest;

- (NSUInteger)count;
- (id)first;

- (NSArray *)all;
- (NSArray *)objectIDs;

- (NSFetchedResultsController *)fetchedResultsController;
- (NSFetchedResultsController *)fetchedResultsControllerWithSectionName:(NSString *)section;

- (id)orCreate;
- (id)orCreate:(NSDictionary *)attributes;

- (void)delete;

@end

@interface NSManagedObject (Composite)

+ (id <NSManagedObjectComposite>)findBy:(NSDictionary *)find;
+ (id <NSManagedObjectComposite>)findBy:(NSDictionary *)find inContext:(NSManagedObjectContext *)context;
+ (id <NSManagedObjectComposite>)findBy:(NSDictionary *)find sortBy:(NSDictionary *)sort;
+ (id <NSManagedObjectComposite>)findBy:(NSDictionary *)find sortBy:(NSDictionary *)sort inContext:(NSManagedObjectContext *)context;

+ (id <NSManagedObjectComposite>)findWhere:(NSString *)where;
+ (id <NSManagedObjectComposite>)findWhere:(NSString *)where inContext:(NSManagedObjectContext *)context;
+ (id <NSManagedObjectComposite>)findWhere:(NSString *)where sortBy:(NSDictionary *)sort;
+ (id <NSManagedObjectComposite>)findWhere:(NSString *)where sortBy:(NSDictionary *)sort inContext:(NSManagedObjectContext *)context;

+ (id <NSManagedObjectComposite>)findWithPredicate:(NSPredicate *)predicate;
+ (id <NSManagedObjectComposite>)findWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;
+ (id <NSManagedObjectComposite>)findWithPredicate:(NSPredicate *)predicate sortBy:(NSDictionary *)sort;
+ (id <NSManagedObjectComposite>)findWithPredicate:(NSPredicate *)predicate sortBy:(NSDictionary *)sort inContext:(NSManagedObjectContext *)context;

+ (id <NSManagedObjectComposite>)sortBy:(NSDictionary *)sort;
+ (id <NSManagedObjectComposite>)sortBy:(NSDictionary *)sort inContext:(NSManagedObjectContext *)context;

@end
