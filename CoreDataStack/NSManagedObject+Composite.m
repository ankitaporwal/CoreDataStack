//
//  NSManagedObject+Composite.m
//  CoreDataStack
//
//  Created by Menno Wildeboer on 02/01/14.
//  Copyright (c) 2014 Menno. All rights reserved.
//

#import "NSManagedObject+Composite.h"
#import "NSError+Stack.h"
#import "NSManagedObject+NSFetchRequest.h"
#import "NSManagedObject+Resource.h"
#import "NSManagedObject+Stack.h"
#import "NSSortDescriptor+Helpers.h"

@interface NSManagedObjectComposite : NSObject <NSManagedObjectComposite>

@property (nonatomic, assign) Class                   managedObjectClass;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchRequest         *fetchRequest;

- (instancetype)initWithManagedObjectClass:(Class)managedObjectClass inContext:(NSManagedObjectContext *)context;

@end

@implementation NSManagedObjectComposite

- (instancetype)initWithManagedObjectClass:(Class)managedObjectClass inContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self)
    {
        _managedObjectClass = managedObjectClass;
        _managedObjectContext = context;
    }
    return self;
}

- (NSUInteger)count
{
    return [_managedObjectClass countFetchRequest:self.fetchRequest inContext:self.managedObjectContext];
}

- (id)first
{
    return [_managedObjectClass executeFetchRequestAndReturnFirstObject:self.fetchRequest inContext:self.managedObjectContext];
}

- (NSArray *)all
{
    return [_managedObjectClass executeFetchRequest:self.fetchRequest inContext:self.managedObjectContext];
}

- (NSArray *)objectIDs
{
    [self.fetchRequest setResultType:NSManagedObjectIDResultType];
    return [_managedObjectClass executeFetchRequest:self.fetchRequest inContext:self.managedObjectContext];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    return [self fetchedResultsControllerWithSectionName:nil];
}

- (NSFetchedResultsController *)fetchedResultsControllerWithSectionName:(NSString *)section
{
    [self.fetchRequest setFetchBatchSize:[NSManagedObject defaultBatchSize]];
    return [[NSFetchedResultsController alloc] initWithFetchRequest:self.fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:section cacheName:nil];
}

- (id)orCreate
{
    id object = [self first];
    if (!object) {
        object = [_managedObjectClass createInContext:self.managedObjectContext];
    }
    return object;
    
}

- (id)orCreate:(NSDictionary *)attributes
{
    id object = [self first];
    [object update:attributes];
    return object;
}

- (void)delete
{
    [[self all] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         [obj delete];
     }];
}

@end

@implementation NSManagedObject (Composite)

+ (id <NSManagedObjectComposite>)findBy:(NSDictionary *)find
{
    return [self findBy:find inContext:[self managedObjectContext]];
}

+ (id <NSManagedObjectComposite>)findBy:(NSDictionary *)find inContext:(NSManagedObjectContext *)context
{
    NSManagedObjectComposite *composite = [[NSManagedObjectComposite alloc] initWithManagedObjectClass:self inContext:context];
    composite.fetchRequest = [self requestWhere:find inContext:context];
    return composite;
}

+ (id <NSManagedObjectComposite>)findBy:(NSDictionary *)find sortBy:(NSDictionary *)sort
{
    return [self findBy:find sortBy:sort inContext:[self managedObjectContext]];
}

+ (id <NSManagedObjectComposite>)findBy:(NSDictionary *)find sortBy:(NSDictionary *)sort inContext:(NSManagedObjectContext *)context
{
    NSManagedObjectComposite *composite = [[NSManagedObjectComposite alloc] initWithManagedObjectClass:self inContext:context];
    composite.fetchRequest = [self requestWhere:find sortedBy:sort inContext:context];
    return composite;
}

+ (id <NSManagedObjectComposite>)findWhere:(NSString *)where
{
    return [self findWhere:where inContext:[self managedObjectContext]];
}

+ (id <NSManagedObjectComposite>)findWhere:(NSString *)where inContext:(NSManagedObjectContext *)context
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:where];
    NSManagedObjectComposite *composite = [[NSManagedObjectComposite alloc] initWithManagedObjectClass:self inContext:context];
    composite.fetchRequest = [self requestWithPredicate:predicate inContext:context];
    return composite;
}

+ (id <NSManagedObjectComposite>)findWhere:(NSString *)where sortBy:(NSDictionary *)sort
{
    return [self findWhere:where sortBy:sort inContext:[self managedObjectContext]];
}

+ (id <NSManagedObjectComposite>)findWhere:(NSString *)where sortBy:(NSDictionary *)sort inContext:(NSManagedObjectContext *)context
{
    NSArray *sortDescriptors = [NSSortDescriptor sortDescriptorsFromDictionary:sort];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:where];
    NSManagedObjectComposite *composite = [[NSManagedObjectComposite alloc] initWithManagedObjectClass:self inContext:context];
    composite.fetchRequest = [self requestWithPredicate:predicate sortedByDescriptors:sortDescriptors inContext:context];
    return composite;
}

+ (id <NSManagedObjectComposite>)findWithPredicate:(NSPredicate *)predicate
{
    return [self findWithPredicate:predicate inContext:[self managedObjectContext]];
}

+ (id <NSManagedObjectComposite>)findWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context
{
    NSManagedObjectComposite *composite = [[NSManagedObjectComposite alloc] initWithManagedObjectClass:self inContext:context];
    composite.fetchRequest = [self requestWithPredicate:predicate inContext:context];
    return composite;
}

+ (id <NSManagedObjectComposite>)findWithPredicate:(NSPredicate *)predicate sortBy:(NSDictionary *)sort
{
    return [self findWithPredicate:predicate sortBy:sort inContext:[self managedObjectContext]];
}

+ (id <NSManagedObjectComposite>)findWithPredicate:(NSPredicate *)predicate sortBy:(NSDictionary *)sort inContext:(NSManagedObjectContext *)context
{
    NSArray *sortDescriptors = [NSSortDescriptor sortDescriptorsFromDictionary:sort];
    NSManagedObjectComposite *composite = [[NSManagedObjectComposite alloc] initWithManagedObjectClass:self inContext:context];
    composite.fetchRequest = [self requestWithPredicate:predicate sortedByDescriptors:sortDescriptors inContext:context];
    return composite;
}

+ (id <NSManagedObjectComposite>)sortBy:(NSDictionary *)sort
{
    return [self sortBy:sort inContext:[self managedObjectContext]];
}

+ (id <NSManagedObjectComposite>)sortBy:(NSDictionary *)sort inContext:(NSManagedObjectContext *)context
{
    NSManagedObjectComposite *composite = [[NSManagedObjectComposite alloc] initWithManagedObjectClass:self inContext:context];
    composite.fetchRequest = [self requestSortedBy:sort inContext:context];
    return composite;

}

@end
