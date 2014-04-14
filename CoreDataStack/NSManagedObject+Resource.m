//
//  NSManagedObject+Resource.m
//  CoreDataStack
//
//  Created by Menno Wildeboer on 02/01/14.
//  Copyright (c) 2014 Menno. All rights reserved.
//

#import "NSManagedObject+Resource.h"
#import "NSManagedObject+Stack.h"
#import "NSManagedObjectContext+Stack.h"
#import "NSPredicate+Helpers.h"
#import "NSSortDescriptor+Helpers.h"

@interface __NSFetchRequestBuilder : NSObject <NSFetchRequestBuilder>

@end

@implementation __NSFetchRequestBuilder

@synthesize entityName = _entityName;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize fetchBatchSize = _fetchBatchSize;
@synthesize fetchLimit = _fetchLimit;
@synthesize fetchOffset = _fetchOffset;
@synthesize predicate = _predicate;
@synthesize resultType = _resultType;
@synthesize sortDescriptors = _sortDescriptors;

- (void)where:(NSDictionary *)where
{
    self.predicate = [NSPredicate predicateFromDictionary:where];
}

- (void)sortBy:(NSDictionary *)sort
{
    self.sortDescriptors = [NSSortDescriptor sortDescriptorsFromDictionary:sort];
}

- (NSArray *)objects
{
    return [self.managedObjectContext executeFetchRequest:[self request] error:NULL];
}

- (NSUInteger)count
{
    return [self.managedObjectContext countForFetchRequest:[self request] error:NULL];
}

- (NSManagedObject *)create
{
    return [NSEntityDescription insertNewObjectForEntityForName:self.entityName inManagedObjectContext:self.managedObjectContext];
}

- (NSFetchRequest *)request
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:self.entityName inManagedObjectContext:self.managedObjectContext];
    request.fetchBatchSize = self.fetchBatchSize;
    request.fetchLimit = self.fetchLimit;
    request.fetchOffset = self.fetchOffset;
    request.predicate = self.predicate;
    request.resultType = self.resultType;
    request.sortDescriptors = self.sortDescriptors;
    return request;
}

@end

@implementation NSManagedObject (Resource)

+ (NSArray *)all:(void (^)(id<NSFetchRequestBuilder> builder))block
{
    return [[self builder:block] objects];
}

+ (NSInteger)count:(void (^)(id<NSFetchRequestBuilder> builder))block
{
    return [[self builder:block] count];
}

+ (NSFetchRequest *)request:(void (^)(id <NSFetchRequestBuilder> builder))block
{
    return [[self builder:block] request];
}

+ (instancetype)find:(void (^)(id<NSFetchRequestBuilder> builder))block
{
    __NSFetchRequestBuilder *builder = [self builder:block];
    builder.fetchLimit = 1;
    return [[builder objects] firstObject];
}

+ (instancetype)findOrCreate:(void (^)(id<NSFetchRequestBuilder> builder))block
{
    id object = [self find:block];
    if (!object) {
        object = [self create:block];
    }
    return object;
}

+ (instancetype)create:(void (^)(id <NSFetchRequestBuilder> builder))block
{
    return [[self builder:block] create];
}

+ (instancetype)createInContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
}

+ (void)delete:(void (^)(id<NSFetchRequestBuilder> builder))block
{
    NSArray *objects = [self all:block];
    [objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        if ([obj isKindOfClass:[NSManagedObject class]]) {
            [obj delete];
        }
    }];
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

+ (__NSFetchRequestBuilder *)builder:(void (^)(id<NSFetchRequestBuilder> builder))block
{
    __NSFetchRequestBuilder *builder = [[__NSFetchRequestBuilder alloc] init];
    if (block) {
        block(builder);
    }
    
    builder.entityName = builder.entityName ?: NSStringFromClass([self class]);
    builder.managedObjectContext = builder.managedObjectContext ?: [self managedObjectContext];
    return builder;
}

@end
