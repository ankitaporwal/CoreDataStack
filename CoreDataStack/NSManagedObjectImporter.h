//
//  NSManagedObjectImporter.h
//  CoreDataStack
//
//  Created by Menno Wildeboer on 17/04/14.
//  Copyright (c) 2014 Menno. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NSImportable <NSObject>

@required
+ (BOOL)allowsDeletion;
+ (NSString *)identifierKey;

+ (id)identifierFromItem:(NSDictionary *)feedItem atIndex:(NSInteger)index;
+ (void)updateEntity:(id)entity withItem:(NSDictionary *)feedItem;

@end


@interface NSManagedObjectImporter : NSObject

@property (nonatomic, assign) Class <NSImportable> objectClass;

- (BOOL)importWithFeed:(NSArray *)objects;

@end
