//
//  NSManagedObject+Resource.h
//  CoreDataStack
//
//  Created by Menno Wildeboer on 02/01/14.
//  Copyright (c) 2014 Menno. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Resource)

+ (NSArray *)all;
+ (NSArray *)allInContext:(NSManagedObjectContext *)context;

+ (id)first;
+ (id)firstInContext:(NSManagedObjectContext *)context;

+ (NSUInteger)count;
+ (NSUInteger)countInContext:(NSManagedObjectContext *)context;

+ (instancetype)create;
+ (instancetype)createInContext:(NSManagedObjectContext *)context;
+ (instancetype)create:(NSDictionary *)attributes;
+ (instancetype)create:(NSDictionary *)attributes inContext:(NSManagedObjectContext *)context;

+ (void)deleteAll;
+ (void)deleteAllInContext:(NSManagedObjectContext *)context;

- (void)update:(NSDictionary *)data;
- (void)delete;

- (void)save;
- (void)saveOnCompletion:(void(^)(BOOL success, NSError *error))completion;

@end
