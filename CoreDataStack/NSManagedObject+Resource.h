//
//  NSManagedObject+Resource.h
//  CoreDataStack
//
//  Created by Menno Wildeboer on 02/01/14.
//  Copyright (c) 2014 Menno. All rights reserved.
//

#import <CoreData/CoreData.h>

@protocol NSFetchRequestBuilder <NSObject>

@required

@property (nonatomic, strong) NSString                *entityName;
@property (nonatomic, strong) NSManagedObjectContext  *managedObjectContext;
@property (nonatomic, assign) NSUInteger               fetchBatchSize;
@property (nonatomic, assign) NSUInteger               fetchLimit;
@property (nonatomic, assign) NSUInteger               fetchOffset;
@property (nonatomic, strong) NSPredicate             *predicate;
@property (nonatomic, assign) NSFetchRequestResultType resultType;
@property (nonatomic, strong) NSArray                 *sortDescriptors;

- (void)where:(NSDictionary *)where;
- (void)sortBy:(NSDictionary *)sort;

@end


@interface NSManagedObject (Resource)

+ (NSArray *)all:(void (^)(id <NSFetchRequestBuilder> builder))block;
+ (NSInteger)count:(void (^)(id <NSFetchRequestBuilder> builder))block;
+ (NSFetchRequest *)request:(void (^)(id <NSFetchRequestBuilder> builder))block;

+ (instancetype)find:(void (^)(id <NSFetchRequestBuilder> builder))block;
+ (instancetype)findOrCreate:(void (^)(id <NSFetchRequestBuilder> builder))block;
+ (instancetype)create:(void (^)(id <NSFetchRequestBuilder> builder))block;

+ (void)delete:(void (^)(id <NSFetchRequestBuilder> builder))block;
- (void)delete;

- (void)save;
- (void)saveOnCompletion:(void(^)(BOOL success, NSError *error))completion;

@end
