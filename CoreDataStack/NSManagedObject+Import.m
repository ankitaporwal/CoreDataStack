//
//  NSManagedObject+Import.m
//  CoreDataStack
//
//  Created by Menno Wildeboer on 17/04/14.
//  Copyright (c) 2014 Menno. All rights reserved.
//

#import "NSManagedObject+Import.h"

@implementation NSManagedObject (Import)

+ (NSManagedObjectImporter *)importer
{
    NSManagedObjectImporter *importer = [[NSManagedObjectImporter alloc] init];
    if ([self.class conformsToProtocol:@protocol(NSImportable)]) {
        importer.objectClass = self.class;
    }
    return importer;
}

+ (BOOL)importWithData:(NSArray *)data
{
    return [[self importer] importWithFeed:data];
}

@end
