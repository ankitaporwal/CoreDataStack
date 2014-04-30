//
//  PersonImporter.h
//  CoreDataStack
//
//  Created by Menno Wildeboer on 30/04/14.
//  Copyright (c) 2014 Menno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDObjectImporter.h"

@interface PersonImporter : CDObjectImporter

@property (nonatomic, assign) BOOL allowsDeletion;

@end
