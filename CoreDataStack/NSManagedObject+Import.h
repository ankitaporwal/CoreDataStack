//
//  NSManagedObject+Import.h
//  CoreDataStack
//
//  Created by Menno Wildeboer on 17/04/14.
//  Copyright (c) 2014 Menno. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "NSManagedObjectImporter.h"

@interface NSManagedObject (Import)

+ (NSManagedObjectImporter *)importer;
+ (BOOL)importWithData:(NSArray *)data;

@end
